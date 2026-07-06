"""
Lists every application currently blocked on CAPTCHA and lets you resume
them one at a time (refill + handoff to resume_captcha.py) so you can clear
a whole batch of manual CAPTCHA solves in one sitting instead of hunting
through Telegram messages one by one.

Run: python3 queue_captcha_blocked.py
"""

import asyncio

from execute_apply_plan import sb_get
from resume_captcha import resume


def main():
    apps = sb_get(
        "applications?status=eq.blocked_on_captcha"
        "&select=job_id,jobs(job_title,companies(company_name))"
    )
    if not apps:
        print("No applications blocked on CAPTCHA.")
        return

    print(f"{len(apps)} application(s) blocked on CAPTCHA:\n")
    for i, a in enumerate(apps, 1):
        job = a.get("jobs") or {}
        company = (job.get("companies") or {}).get("company_name", "?")
        print(f"  {i}. {company} — {job.get('job_title', '?')}  (job_id={a['job_id']})")

    for a in apps:
        job = a.get("jobs") or {}
        company = (job.get("companies") or {}).get("company_name", "?")
        answer = input(
            f"\nResume '{company} — {job.get('job_title')}'? [y/N/q to quit]: "
        ).strip().lower()
        if answer == "q":
            break
        if answer == "y":
            asyncio.run(resume(a["job_id"]))


if __name__ == "__main__":
    main()
