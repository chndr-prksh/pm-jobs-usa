"""
Resume-session handoff for a CAPTCHA-blocked application: refills the form
deterministically (same fill logic as execute_apply_plan.py) in a headed
(visible) browser, then leaves it open for you to solve the CAPTCHA and
click Submit yourself. Never attempts the CAPTCHA itself.

Run: python3 resume_captcha.py <job_id>
"""

from __future__ import annotations

import asyncio
import sys

from playwright.async_api import async_playwright

from execute_apply_plan import sb_get, fill_field, download_base_resume


async def resume(job_id: str):
    plan_rows = sb_get(f"application_plans?job_id=eq.{job_id}&select=*")
    if not plan_rows:
        print(f"[{job_id}] No plan found — run build_apply_plan.py first")
        return
    plan = plan_rows[0]

    job = sb_get(f"jobs?id=eq.{job_id}&select=apply_url,job_title,company_id")[0]
    company = sb_get(f"companies?id=eq.{job['company_id']}&select=company_name,ats")[0]
    label = f"{company['company_name']} — {job['job_title']}"

    templates = {
        t["field_name"]: t["selector"]
        for t in sb_get(f"ats_field_templates?ats=eq.{company['ats']}&select=field_name,selector")
    }

    resume_path = "/tmp/base_resume.pdf"
    download_base_resume(resume_path)

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        context = await browser.new_context(ignore_https_errors=True)
        page = await context.new_page()
        await page.goto(job["apply_url"], wait_until="domcontentloaded", timeout=30000)
        await page.wait_for_timeout(2000)

        if not await page.query_selector("input"):
            apply_control = await page.query_selector("a:has-text('Apply'), button:has-text('Apply')")
            if apply_control and await apply_control.is_visible():
                await apply_control.click()
                await page.wait_for_timeout(2000)

        for field in plan["fields"]:
            if field["field_name"] == "submit_button" or field.get("needs_escalation"):
                continue
            if field["field_name"] in templates:
                field["selector"] = templates[field["field_name"]]
            await fill_field(page, field, resume_path)

        print(f"\n{label}")
        print("Form refilled from the saved plan. Solve the CAPTCHA and click Submit yourself.")
        print("Close the browser window when you're done.")

        try:
            await page.wait_for_event("close", timeout=0)
        except Exception:
            pass
        try:
            await browser.close()
        except Exception:
            pass


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 resume_captcha.py <job_id>")
        sys.exit(1)
    asyncio.run(resume(sys.argv[1]))
