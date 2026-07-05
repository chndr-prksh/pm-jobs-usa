"""
Planning phase: one Claude API call per job (no Managed Agent, no browser).
Reads candidate_profile, question_bank, ats_field_templates, and the job's
JD, and produces a concrete field-by-field fill plan saved to
application_plans. The execution phase (execute_apply_plan.py) then runs
this plan deterministically with no LLM calls except inline repair.

Run: python3 build_apply_plan.py <job_id>
"""

from __future__ import annotations

import json
import os
import sys

import requests
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()

PLAN_PROMPT = """You are building a deterministic fill plan for a job application, so a plain
browser-automation script (no LLM involved) can execute it without any judgment calls of its own.

CANDIDATE PROFILE:
{candidate_profile}

KNOWN ANSWERS (question_bank — key/value answers to questions seen before, including
AI-drafted behavioral answers from past applications):
{question_bank}

KNOWN FIELD SELECTORS for this ATS ({ats}) from past successful fills — reuse these exactly,
don't invent new ones for fields already covered here:
{field_templates}

JOB POSTING:
Title: {job_title}
Description:
---
{description}
---

Your job: return a JSON array of field objects for EVERY field this application form is likely
to have, based on the per-ATS pattern for {ats} and the known field templates above. For each:

{{
  "field_name": string (e.g. "full_name", "email", "resume_upload", "linkedin_url",
                 or a normalized question_key for a custom question),
  "field_type": one of ["text", "file", "select", "checkbox", "radio", "textarea"],
  "selector": string or null (use the known selector from field_templates if available for this
              field_name + ats; null if genuinely unknown — the executor will discover it),
  "value": string or null (the actual value to fill; null if this needs escalation),
  "needs_escalation": boolean (true if this is a factual/personal-status question with no answer
                       in question_bank — visa sponsorship, salary, relocation, clearance, etc.
                       False if you found a real value in question_bank or candidate_profile, or
                       if it's a resume-answerable open-ended question you should draft here)
}}

For open-ended/behavioral questions not yet in question_bank, DRAFT the answer yourself right
now using real specifics from candidate_profile's work_history — set needs_escalation to false
and put your drafted answer in "value". For factual/personal-status questions (visa, salary,
relocation, clearance) with no answer in question_bank, set needs_escalation to true and value
to null — the executor will flag these for the user rather than guess.

ALWAYS include one final entry with `field_name: "submit_button"`, `field_type: "button"`,
`value: null`, `needs_escalation: false`, and `selector` from field_templates if known (the
executor clicks this last, only if no other field has needs_escalation = true).

Return ONLY the JSON array, no markdown, no commentary.
"""


def get_conn_headers():
    return {
        "apikey": os.environ["SUPABASE_SERVICE_KEY"],
        "Authorization": f"Bearer {os.environ['SUPABASE_SERVICE_KEY']}",
        "Content-Type": "application/json",
    }


def supabase_get(path: str):
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/rest/v1/" + path
    r = requests.get(url, headers=get_conn_headers(), timeout=15)
    r.raise_for_status()
    return r.json()


def supabase_upsert(table: str, payload: dict, on_conflict: str | None = None):
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/rest/v1/" + table
    params = {"on_conflict": on_conflict} if on_conflict else {}
    headers = {**get_conn_headers(), "Prefer": "resolution=merge-duplicates,return=representation"}
    r = requests.post(url, headers=headers, params=params, json=payload, timeout=15)
    r.raise_for_status()
    return r.json()


def build_plan(job_id: str):
    job_rows = supabase_get(f"jobs?id=eq.{job_id}&select=id,job_title,description,company_id")
    if not job_rows:
        raise RuntimeError(f"No job found with id {job_id}")
    job = job_rows[0]

    company = supabase_get(f"companies?id=eq.{job['company_id']}&select=company_name,ats")[0]
    ats = company["ats"]

    profile = supabase_get("candidate_profile?select=*")[0]
    question_bank = supabase_get("question_bank?select=question_key,question_text,answer_value,category")
    templates = supabase_get(f"ats_field_templates?ats=eq.{ats}&select=field_name,selector,field_type,notes")

    prompt = PLAN_PROMPT.format(
        candidate_profile=json.dumps(profile, default=str),
        question_bank=json.dumps(question_bank, default=str),
        field_templates=json.dumps(templates, default=str),
        ats=ats,
        job_title=job["job_title"],
        description=job["description"] or "(no description available)",
    )

    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    message = client.messages.create(
        model="claude-sonnet-5",
        max_tokens=4096,
        messages=[{"role": "user", "content": prompt}],
    )
    text = next(b.text for b in message.content if b.type == "text").strip()
    if text.startswith("```"):
        text = text.split("```")[1]
        if text.startswith("json"):
            text = text[4:]
    fields = json.loads(text)

    supabase_upsert(
        "application_plans",
        {"job_id": job_id, "ats": ats, "fields": fields, "status": "ready"},
        on_conflict="job_id",
    )

    return job, company, fields


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 build_apply_plan.py <job_id>")
        sys.exit(1)

    job_id = sys.argv[1]
    job, company, fields = build_plan(job_id)

    print(f"Plan built for {company['company_name']} — {job['job_title']} ({company['ats']})")
    print(f"{len(fields)} fields:")
    for f in fields:
        flag = " [NEEDS ESCALATION]" if f.get("needs_escalation") else ""
        print(f"  {f['field_name']:30s} ({f['field_type']:10s}) selector={f['selector']}{flag}")


if __name__ == "__main__":
    main()
