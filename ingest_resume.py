"""
Phase 2: Resume ingestion.

Parses a resume file into candidate_profile via the Claude API, uploads the
original file to Supabase Storage, and seeds question_bank with the obvious
answers (name/email/phone/location/title) so the future autofill agent never
has to ask for them again.

Run: python3 ingest_resume.py /path/to/resume.pdf

Requires env vars (in .env or shell) — never paste these values in chat:
  SUPABASE_DB_URL       - existing Postgres connection string
  SUPABASE_URL          - e.g. https://xxxx.supabase.co
  SUPABASE_SERVICE_KEY  - service role key, needed for Storage write access
  ANTHROPIC_API_KEY     - Claude API key
"""

from __future__ import annotations

import json
import os
import sys
import uuid

import psycopg2
import psycopg2.extras
import requests
from anthropic import Anthropic
from dotenv import load_dotenv
from pypdf import PdfReader

load_dotenv()

EXTRACTION_PROMPT = """You are extracting structured data from a resume for a job-application autofill system.
Read the resume text below and return ONLY a JSON object (no markdown, no commentary) with this exact shape:

{{
  "full_name": string,
  "email": string,
  "phone": string,
  "location": string,
  "linkedin_url": string or null,
  "portfolio_url": string or null,
  "current_title": string,
  "years_experience": number,
  "summary": string (2-3 sentence professional summary),
  "skills": [string, ...],
  "work_history": [
    {{"company": string, "title": string, "start_date": string, "end_date": string, "description": string}}
  ],
  "education": [
    {{"school": string, "degree": string, "field": string, "start_date": string, "end_date": string}}
  ]
}}

Resume text:
---
{resume_text}
---
"""


def extract_text(path: str) -> str:
    reader = PdfReader(path)
    return "\n".join(page.extract_text() for page in reader.pages)


def parse_with_claude(resume_text: str) -> dict:
    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    message = client.messages.create(
        model="claude-sonnet-5",
        max_tokens=4096,
        messages=[{
            "role": "user",
            "content": EXTRACTION_PROMPT.format(resume_text=resume_text),
        }],
    )
    text = message.content[0].text.strip()
    if text.startswith("```"):
        text = text.split("```")[1]
        if text.startswith("json"):
            text = text[4:]
    return json.loads(text)


def upload_to_storage(local_path: str, storage_path: str) -> str:
    supabase_url = os.environ["SUPABASE_URL"].rstrip("/")
    service_key = os.environ["SUPABASE_SERVICE_KEY"]
    with open(local_path, "rb") as f:
        content = f.read()
    resp = requests.post(
        f"{supabase_url}/storage/v1/object/resumes/{storage_path}",
        headers={
            "Authorization": f"Bearer {service_key}",
            "apikey": service_key,
            "Content-Type": "application/pdf",
            "x-upsert": "true",
        },
        data=content,
        timeout=30,
    )
    resp.raise_for_status()
    return storage_path


def save_candidate_profile(conn, profile: dict):
    with conn.cursor() as cur:
        cur.execute("SELECT id FROM candidate_profile LIMIT 1")
        row = cur.fetchone()
        args = (
            profile["full_name"], profile["email"], profile["phone"], profile["location"],
            profile.get("linkedin_url"), profile.get("portfolio_url"), profile["current_title"],
            profile["years_experience"], profile["summary"],
            psycopg2.extras.Json(profile["skills"]),
            psycopg2.extras.Json(profile["work_history"]),
            psycopg2.extras.Json(profile["education"]),
        )
        if row:
            cur.execute("""
                UPDATE candidate_profile SET
                    full_name = %s, email = %s, phone = %s, location = %s,
                    linkedin_url = %s, portfolio_url = %s, current_title = %s,
                    years_experience = %s, summary = %s,
                    skills = %s, work_history = %s, education = %s,
                    updated_at = now()
                WHERE id = %s
            """, args + (row[0],))
        else:
            cur.execute("""
                INSERT INTO candidate_profile (
                    full_name, email, phone, location, linkedin_url, portfolio_url,
                    current_title, years_experience, summary, skills, work_history, education
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, args)
    conn.commit()


def save_resume_record(conn, storage_path: str, file_name: str):
    with conn.cursor() as cur:
        cur.execute("UPDATE resumes SET is_base = false WHERE is_base = true")
        cur.execute("""
            INSERT INTO resumes (version_label, file_url, file_name, is_base)
            VALUES (%s, %s, %s, true)
        """, ("base", storage_path, file_name))
    conn.commit()


def seed_question_bank(conn, profile: dict):
    seed = [
        ("full_name", "What is your full legal name?", profile.get("full_name"), "identity"),
        ("email", "What is your email address?", profile.get("email"), "identity"),
        ("phone", "What is your phone number?", profile.get("phone"), "identity"),
        ("location", "What is your current location?", profile.get("location"), "identity"),
        ("linkedin_url", "LinkedIn profile URL", profile.get("linkedin_url"), "identity"),
        ("current_title", "What is your current job title?", profile.get("current_title"), "experience"),
        ("years_experience", "How many years of relevant experience do you have?",
         str(profile["years_experience"]) if profile.get("years_experience") is not None else None,
         "experience"),
    ]
    with conn.cursor() as cur:
        for key, text, answer, category in seed:
            if answer is None:
                continue
            cur.execute("""
                INSERT INTO question_bank (question_key, question_text, answer_value, category)
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (question_key) DO UPDATE SET
                    answer_value = EXCLUDED.answer_value,
                    last_updated = now()
            """, (key, text, answer, category))
    conn.commit()


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 ingest_resume.py /path/to/resume.pdf")
        sys.exit(1)

    path = sys.argv[1]
    file_name = os.path.basename(path)

    print(f"Extracting text from {file_name}...")
    resume_text = extract_text(path)

    print("Parsing with Claude API...")
    profile = parse_with_claude(resume_text)
    print(f"Parsed: {profile['full_name']} — {profile['current_title']}")

    storage_path = f"base/{uuid.uuid4()}_{file_name}"
    print(f"Uploading to Supabase Storage: {storage_path}...")
    upload_to_storage(path, storage_path)

    conn = psycopg2.connect(os.environ["SUPABASE_DB_URL"])
    save_resume_record(conn, storage_path, file_name)
    save_candidate_profile(conn, profile)
    seed_question_bank(conn, profile)
    conn.close()

    print("Done. candidate_profile, resumes, and question_bank are seeded.")


if __name__ == "__main__":
    main()
