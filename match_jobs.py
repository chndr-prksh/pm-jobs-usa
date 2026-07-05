"""
Phase 3: Nightly job matching.

Scores newly-scraped PM jobs against candidate_profile via the Claude API,
incrementally — only jobs where is_pm_role = true, is_active = true,
description IS NOT NULL, and no job_matches row exists yet.

Uses Haiku 4.5: this is bounded, structured judgment (compare JD text to
a resume profile), not open-ended reasoning — Sonnet-level quality isn't
needed here and this runs on every new PM job, so cost scales with volume.

Run: python3 match_jobs.py (called from main.py after enrich_pm_jobs.py)
"""

from __future__ import annotations

import json
import os

import psycopg2
import psycopg2.extras
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()

MATCH_PROMPT = """You are scoring how well a candidate fits a Product Manager job posting.

CANDIDATE PROFILE:
- Current title: {current_title}
- Total career experience: {years_experience} years
- Product-management-track experience (PM / Senior PM / Group PM / Director-of-Product titles only): {pm_years_experience} years
- Skills: {skills}
- Work history: {work_history}
- Education: {education}

JOB POSTING:
Title: {job_title}
Description:
---
{description}
---

Return ONLY a JSON object (no markdown, no commentary) with this exact shape:

{{
  "relevance_score": number (0-100, how well the candidate fits this specific posting),
  "seniority_level": one of ["IC", "Manager", "Senior Manager", "Director", "VP"] (infer from the JD's stated years-experience requirement, scope, and title-band, not just the job title string),
  "matched_skills": [string, ...] (skills/experience the candidate has that this JD wants),
  "missing_skills": [string, ...] (skills/requirements this JD wants that the candidate's profile doesn't show),
  "reasoning": string (2-3 sentences: why this score, calling out any experience-years mismatch or seniority mismatch explicitly)
}}
"""


def get_conn():
    return psycopg2.connect(os.environ["SUPABASE_DB_URL"])


def get_candidate_profile(conn) -> dict:
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute("SELECT * FROM candidate_profile LIMIT 1")
        profile = cur.fetchone()
    if not profile:
        raise RuntimeError("No candidate_profile row found — run ingest_resume.py first")
    return dict(profile)


def get_unscored_pm_jobs(conn) -> list[dict]:
    test_mode = os.environ.get("TEST_MODE", "").lower() == "true"
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute(f"""
            SELECT j.id, j.job_title, j.description
            FROM jobs j
            LEFT JOIN job_matches m ON m.job_id = j.id
            WHERE j.is_pm_role = true
              AND j.is_active = true
              AND j.description IS NOT NULL
              AND m.id IS NULL
              {"AND j.is_test_job = true" if test_mode else ""}
        """)
        return [dict(r) for r in cur.fetchall()]


def score_job(client: Anthropic, profile: dict, job: dict) -> dict:
    prompt = MATCH_PROMPT.format(
        current_title=profile.get("current_title"),
        years_experience=profile.get("years_experience"),
        pm_years_experience=profile.get("pm_years_experience"),
        skills=json.dumps(profile.get("skills") or []),
        work_history=json.dumps(profile.get("work_history") or []),
        education=json.dumps(profile.get("education") or []),
        job_title=job["job_title"],
        description=job["description"],
    )
    message = client.messages.create(
        model="claude-haiku-4-5",
        max_tokens=1024,
        messages=[{"role": "user", "content": prompt}],
    )
    text = next(block.text for block in message.content if block.type == "text").strip()
    if text.startswith("```"):
        text = text.split("```")[1]
        if text.startswith("json"):
            text = text[4:]
    return json.loads(text)


def save_match(conn, job_id: str, result: dict):
    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO job_matches (job_id, relevance_score, seniority_level, matched_skills, missing_skills, reasoning)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON CONFLICT (job_id) DO UPDATE SET
                relevance_score = EXCLUDED.relevance_score,
                seniority_level = EXCLUDED.seniority_level,
                matched_skills = EXCLUDED.matched_skills,
                missing_skills = EXCLUDED.missing_skills,
                reasoning = EXCLUDED.reasoning,
                scored_at = now()
        """, (
            job_id,
            result["relevance_score"],
            result["seniority_level"],
            psycopg2.extras.Json(result["matched_skills"]),
            psycopg2.extras.Json(result["missing_skills"]),
            result["reasoning"],
        ))
    conn.commit()


def run():
    conn = get_conn()
    profile = get_candidate_profile(conn)
    jobs = get_unscored_pm_jobs(conn)

    print(f"Scoring {len(jobs)} unscored PM jobs against candidate_profile...")

    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    scored, failed = 0, 0

    for job in jobs:
        try:
            result = score_job(client, profile, job)
            save_match(conn, job["id"], result)
            scored += 1
        except Exception as e:
            print(f"[{job['job_title']}] FAILED — {e}")
            failed += 1

    conn.close()
    print(f"Scored: {scored} | Failed: {failed}")


if __name__ == "__main__":
    run()
