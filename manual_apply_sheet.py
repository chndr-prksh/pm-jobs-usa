"""
Replaces the old resume_captcha.py approach for ATS platforms whose bot
detection rejects the SESSION, not just the CAPTCHA widget — Lever returned
"Unable to verify the application" even after the CAPTCHA was solved by
hand, because a Playwright-controlled browser leaves detectable automation
markers (e.g. navigator.webdriver) regardless of who does the clicking.

Fix: don't touch that ATS with an automated browser at all. Generate a
plain-text fill sheet (every field + its exact value, plus the resume file
path) and open the real apply page in your normal, non-automated browser.
You paste the values in yourself — the session Lever sees is 100% real,
because nothing about it was ever automated.

Run: python3 manual_apply_sheet.py <job_id>
"""

from __future__ import annotations

import sys
import webbrowser

from execute_apply_plan import sb_get, download_base_resume


def build_sheet(job_id: str):
    plan_rows = sb_get(f"application_plans?job_id=eq.{job_id}&select=*")
    if not plan_rows:
        print(f"[{job_id}] No plan found — run build_apply_plan.py first")
        return
    plan = plan_rows[0]

    job = sb_get(f"jobs?id=eq.{job_id}&select=apply_url,job_title,company_id")[0]
    company = sb_get(f"companies?id=eq.{job['company_id']}&select=company_name")[0]

    resume_path = "/tmp/base_resume.pdf"
    download_base_resume(resume_path)

    print(f"\n{'=' * 70}")
    print(f"{company['company_name']} — {job['job_title']}")
    print(f"{'=' * 70}")
    print(f"\nApply URL (opening in your default browser now):\n  {job['apply_url']}\n")
    print(f"Resume file to upload: {resume_path}\n")
    print("Copy these values into the form as you go:\n")

    for field in plan["fields"]:
        if field["field_name"] in ("submit_button", "resume_upload"):
            continue
        label = field.get("label") or field["field_name"]
        value = field.get("value")
        flag = "  [YOU NEED TO ANSWER THIS — no answer on file]" if field.get("needs_escalation") else ""
        print(f"  {label}{flag}")
        if value:
            print(f"    -> {value}")
        print()

    webbrowser.open(job["apply_url"])


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 manual_apply_sheet.py <job_id>")
        sys.exit(1)
    build_sheet(sys.argv[1])
