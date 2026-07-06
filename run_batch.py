"""
Orchestrates the deterministic pipeline for the next batch of high-scoring
job matches: builds a plan for each (if missing), then executes them
concurrently. Prioritizes companies with fewer past CAPTCHA incidents on
their ATS, since a company that's repeatedly gated applications behind a
hard CAPTCHA wall is unlikely to complete without your manual assist
anyway — better to spend automated runs on jobs that can actually finish.

Run: python3 run_batch.py [batch_size]
"""

from __future__ import annotations

import asyncio
import os
import sys

from anthropic import Anthropic
from dotenv import load_dotenv
from playwright.async_api import async_playwright

from build_apply_plan import build_plan
from execute_apply_plan import sb_get, execute_one, download_base_resume

load_dotenv()

SUPPORTED_ATS = ("greenhouse", "lever", "ashby")


def next_batch(limit: int) -> list[str]:
    matches = sb_get(
        "job_matches?relevance_score=gte.60"
        "&select=job_id,relevance_score,jobs(id,company_id,is_us_job,companies(id,company_name,ats))"
        "&order=relevance_score.desc&limit=200"
    )
    already = {a["job_id"] for a in sb_get("applications?select=job_id")}

    incidents = sb_get("captcha_incidents?select=company_id")
    risk: dict[str, int] = {}
    for i in incidents:
        risk[i["company_id"]] = risk.get(i["company_id"], 0) + 1

    candidates = []
    for m in matches:
        job = m.get("jobs") or {}
        company = job.get("companies") or {}
        job_id = job.get("id")
        if not job_id or job_id in already:
            continue
        if job.get("is_us_job") is False:
            continue
        if company.get("ats") not in SUPPORTED_ATS:
            continue
        candidates.append((
            risk.get(company.get("id"), 0),
            -m["relevance_score"],
            job_id,
            company.get("company_name"),
        ))

    candidates.sort()
    for risk_count, neg_score, job_id, name in candidates[:limit]:
        print(f"  queued: {name} (captcha incidents so far: {risk_count}, score: {-neg_score})")
    return [c[2] for c in candidates[:limit]]


async def main(job_ids: list[str]):
    resume_path = "/tmp/base_resume.pdf"
    download_base_resume(resume_path)
    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        await asyncio.gather(*[
            execute_one(job_id, resume_path, browser, client) for job_id in job_ids
        ])
        await browser.close()


if __name__ == "__main__":
    batch_size = int(sys.argv[1]) if len(sys.argv) > 1 else 5

    job_ids = next_batch(batch_size)
    if not job_ids:
        print("No eligible jobs to process.")
        sys.exit(0)

    # build_plan() uses Playwright's SYNC API internally — must run before
    # asyncio.run() starts an event loop, or Playwright refuses to launch.
    for job_id in job_ids:
        try:
            build_plan(job_id)
        except Exception as e:
            print(f"[{job_id}] plan build failed: {e}")

    asyncio.run(main(job_ids))
