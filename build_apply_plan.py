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
from playwright.sync_api import sync_playwright

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

ACTUAL APPLICATION PAGE HTML (ground your field list in this — don't invent fields that aren't
really on this page, and don't skip custom questions that ARE on it just because they weren't in
a prior company's question_bank):
---
{page_html}
---

Your job: return a JSON array of field objects for EVERY field that ACTUALLY APPEARS on this
specific application page (per the HTML above), not a generic guess. For each:

{{
  "field_name": string (e.g. "full_name", "email", "resume_upload", "linkedin_url",
                 or a normalized question_key for a custom question),
  "field_type": one of ["text", "file", "select", "checkbox", "radio", "textarea"],
  "label": string or null (the EXACT visible label/placeholder/aria-label text for this field as
           it literally appears on the page HTML — used to locate the field by accessible name,
           which survives CSS class/id changes across ATS redeploys. null only if genuinely
           unlabeled),
  "selector": string or null (use the known selector from field_templates if available for this
              field_name + ats; null if genuinely unknown — the executor will discover it),
  "value": string or null (the actual value to fill; null if this needs escalation),
  "needs_escalation": boolean (true ONLY if genuinely unanswerable — see rules below)
}}

CRITICAL — for option fields (radio, select, single checkbox that is one choice among several,
or a checkbox group), the "value" MUST be the EXACT visible option label text as it literally
appears in the page HTML above — not a paraphrase and not the raw phrasing from the candidate's
stored data. Example: if the candidate's stored veteran status is "Not a veteran" but the page's
actual option reads "I am not a protected veteran", set value to "I am not a protected veteran".
Read the real options off the HTML and pick the one that matches the candidate's facts.

ANSWER, DON'T ESCALATE. The candidate_profile includes structured ontology objects you must use
as the authoritative source of truth:
  - work_authorization: {{authorized_us, needs_sponsorship, citizenship, citizenship_country,
    visa_type, eligible_clearance}}. Derive ALL of these regardless of how the question is phrased:
      * "Are you authorized/eligible to work in the US / without restriction?" -> use authorized_us
      * "Do you now or will you need sponsorship?" -> use needs_sponsorship
      * "Are you a US citizen / US person?" -> use citizenship (this candidate is NOT a US citizen)
      * "Immigration status / visa type" -> use visa_type / citizenship_country
  - demographics: {{pronouns, gender, race_ethnicity, veteran_status, disability_status}}. Use these
    for ALL EEO/voluntary self-identification questions (gender, race, veteran, disability). Map to
    the closest real on-page option. This candidate is NOT a veteran.
  - preferences: {{willing_to_relocate, open_to_in_office, open_to_hybrid}}. ALWAYS answer YES /
    affirmative to any question about relocation, in-office attendance, commuting distance, hybrid,
    or willingness to be onsite.

For plain acknowledgment checkboxes (privacy notice, "I acknowledge", age-info redaction, consent
to terms), set value to the affirmative/acknowledged option and needs_escalation false — these are
routine consents, never escalate them.

For open-ended/behavioral questions not yet in question_bank, DRAFT the answer yourself right now
using real specifics from candidate_profile's work_history — needs_escalation false, drafted answer
in "value".

Set needs_escalation true ONLY when the answer is a hard fact that is genuinely absent from ALL of
the above AND cannot be reasonably inferred (e.g. a specific salary expectation figure never
provided, or a security-clearance level the candidate never stated). Demographic, work-auth,
citizenship, sponsorship, relocation, and consent questions are NEVER escalations — you have the
data to answer every one of them.

File-upload fields (resume, cover letter as a file) are NEVER needs_escalation — the executor
always fills these automatically with the mounted resume file, regardless of "value". Only set
needs_escalation on file fields if the form asks for something that isn't the resume (e.g. a
portfolio file the candidate doesn't have).

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


def fetch_rendered_html(url: str, max_chars: int = 60000) -> str:
    """Greenhouse/Lever/Ashby apply forms are JS-rendered — a plain GET only
    returns the app shell. Load with Playwright once to get the real DOM.
    This is a deterministic browser fetch, not an LLM call.

    Ashby and Lever (unlike Greenhouse) land on a job DESCRIPTION page —
    the actual form only renders after clicking an "Apply" control. Click
    through it here so the planner sees the real form fields, not just the
    posting text."""
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page(ignore_https_errors=True)
        try:
            page.goto(url, wait_until="domcontentloaded", timeout=30000)
            page.wait_for_timeout(2000)
            if not page.query_selector("input"):
                apply_control = page.query_selector(
                    "a:has-text('Apply'), button:has-text('Apply')"
                )
                if apply_control and apply_control.is_visible():
                    apply_control.click()
                    page.wait_for_timeout(2000)

            # Some ATS pages (Lever especially) inline huge amounts of
            # unrelated markup/scripts before the actual <form> — truncating
            # from the start of the page can cut the form off entirely.
            # Prefer just the form's own HTML when one exists.
            form = page.query_selector("form")
            html = form.evaluate("el => el.outerHTML") if form else page.content()
        finally:
            browser.close()
    return html[:max_chars]


def build_plan(job_id: str):
    job_rows = supabase_get(f"jobs?id=eq.{job_id}&select=id,job_title,description,company_id,apply_url")
    if not job_rows:
        raise RuntimeError(f"No job found with id {job_id}")
    job = job_rows[0]

    company = supabase_get(f"companies?id=eq.{job['company_id']}&select=company_name,ats")[0]
    ats = company["ats"]

    profile = supabase_get("candidate_profile?select=*")[0]
    question_bank = supabase_get("question_bank?select=question_key,question_text,answer_value,category")
    templates = supabase_get(f"ats_field_templates?ats=eq.{ats}&select=field_name,selector,field_type,notes")
    page_html = fetch_rendered_html(job["apply_url"])

    prompt = PLAN_PROMPT.format(
        candidate_profile=json.dumps(profile, default=str),
        question_bank=json.dumps(question_bank, default=str),
        field_templates=json.dumps(templates, default=str),
        ats=ats,
        job_title=job["job_title"],
        description=job["description"] or "(no description available)",
        page_html=page_html,
    )

    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    message = client.messages.create(
        model="claude-sonnet-5",
        max_tokens=8192,
        messages=[{"role": "user", "content": prompt}],
    )
    text = next((b.text for b in message.content if b.type == "text"), "[]").strip()
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
