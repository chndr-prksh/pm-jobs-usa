"""
Execution phase: plain Playwright, NO LLM calls except inline repair when
something doesn't match the plan (missing/broken selector, or a field the
planner didn't anticipate). Repair happens in the SAME browser session —
no restart, no separate agent session. Runs N jobs concurrently via
asyncio, each with its own browser context.

Run: python3 execute_apply_plan.py <job_id> [<job_id> ...]
"""

from __future__ import annotations

import asyncio
import base64
import json
import os
import sys

import requests
from anthropic import Anthropic
from dotenv import load_dotenv
from playwright.async_api import async_playwright, Page

load_dotenv()

CAPTCHA_MARKERS = ["hcaptcha", "recaptcha", "g-recaptcha", "cf-turnstile"]


def sb_headers():
    key = os.environ["SUPABASE_SERVICE_KEY"]
    return {"apikey": key, "Authorization": f"Bearer {key}", "Content-Type": "application/json"}


def sb_get(path: str):
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/rest/v1/" + path
    r = requests.get(url, headers=sb_headers(), timeout=15)
    r.raise_for_status()
    return r.json()


def sb_patch(table: str, filter_str: str, payload: dict):
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/rest/v1/" + table + "?" + filter_str
    r = requests.patch(url, headers=sb_headers(), json=payload, timeout=15)
    r.raise_for_status()


def sb_insert(table: str, payload: dict):
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/rest/v1/" + table
    headers = {**sb_headers(), "Prefer": "return=representation"}
    r = requests.post(url, headers=headers, json=payload, timeout=15)
    r.raise_for_status()
    return r.json()


def sb_upsert(table: str, payload: dict, on_conflict: str):
    url = os.environ["SUPABASE_URL"].rstrip("/") + "/rest/v1/" + table
    headers = {**sb_headers(), "Prefer": "resolution=merge-duplicates,return=representation"}
    r = requests.post(url, headers=headers, params={"on_conflict": on_conflict}, json=payload, timeout=15)
    r.raise_for_status()
    return r.json()


def upload_storage(bucket: str, path: str, content: bytes, content_type: str):
    url = f"{os.environ['SUPABASE_URL'].rstrip('/')}/storage/v1/object/{bucket}/{path}"
    key = os.environ["SUPABASE_SERVICE_KEY"]
    r = requests.post(
        url,
        headers={"apikey": key, "Authorization": f"Bearer {key}", "Content-Type": content_type, "x-upsert": "true"},
        data=content,
        timeout=30,
    )
    r.raise_for_status()


def download_base_resume(local_path: str):
    rows = sb_get("resumes?is_base=eq.true&select=file_url")
    if not rows:
        raise RuntimeError("No base resume — run ingest_resume.py first")
    file_url = rows[0]["file_url"]
    key = os.environ["SUPABASE_SERVICE_KEY"]
    r = requests.get(
        f"{os.environ['SUPABASE_URL'].rstrip('/')}/storage/v1/object/resumes/{file_url}",
        headers={"apikey": key, "Authorization": f"Bearer {key}"},
        timeout=30,
    )
    r.raise_for_status()
    with open(local_path, "wb") as f:
        f.write(r.content)


def telegram_send_text(text: str):
    token = os.environ["TELEGRAM_BOT_TOKEN"]
    chat_id = os.environ["TELEGRAM_CHAT_ID"]
    requests.post(
        f"https://api.telegram.org/bot{token}/sendMessage",
        json={"chat_id": chat_id, "text": text},
        timeout=15,
    )


def telegram_send_photo(photo_bytes: bytes, caption: str, application_id: str | None = None):
    token = os.environ["TELEGRAM_BOT_TOKEN"]
    chat_id = os.environ["TELEGRAM_CHAT_ID"]
    data = {"chat_id": chat_id, "caption": caption[:1024]}
    if application_id:
        data["reply_markup"] = json.dumps({
            "inline_keyboard": [[
                {"text": "✅ Good", "callback_data": f"good:{application_id}"},
                {"text": "🚩 Flag", "callback_data": f"flag:{application_id}"},
            ]]
        })
    requests.post(
        f"https://api.telegram.org/bot{token}/sendPhoto",
        data=data,
        files={"photo": ("screenshot.png", photo_bytes, "image/png")},
        timeout=30,
    )


async def repair_selector(page: Page, field: dict, client: Anthropic) -> str | None:
    """Inline repair: ask Claude for a corrected selector using the live page's HTML,
    without leaving this browser session or spinning up a separate agent session."""
    html = await page.content()
    # Trim to a reasonable size — most forms fit well within this
    html = html[:40000]

    prompt = (
        f"Here is the current HTML of a job application page. I need the CSS selector for the "
        f"field '{field['field_name']}' (type: {field['field_type']}). "
        f"Return ONLY the selector as a plain string, no markdown, no explanation. "
        f"If the field genuinely doesn't exist on this page, return exactly: NONE\n\n"
        f"HTML:\n{html}"
    )
    message = client.messages.create(
        model="claude-sonnet-5",
        max_tokens=256,
        messages=[{"role": "user", "content": prompt}],
    )
    text = next(b.text for b in message.content if b.type == "text").strip()
    return None if text == "NONE" else text


async def fill_field(page: Page, field: dict, resume_path: str) -> bool:
    selector, ftype, value = field["selector"], field["field_type"], field.get("value")
    if not selector:
        return False
    try:
        if ftype == "file":
            await page.set_input_files(selector, resume_path)
        elif ftype in ("text", "textarea"):
            await page.fill(selector, value or "")
        elif ftype == "select":
            await page.select_option(selector, value or "")
        elif ftype in ("checkbox", "radio"):
            await page.check(selector)
        elif ftype == "button":
            pass  # submit_button is clicked separately, not "filled"
        return True
    except Exception:
        return False


async def has_captcha(page: Page) -> bool:
    content = (await page.content()).lower()
    return any(marker in content for marker in CAPTCHA_MARKERS)


async def execute_one(job_id: str, resume_path: str, browser, client: Anthropic):
    plan_rows = sb_get(f"application_plans?job_id=eq.{job_id}&select=*")
    if not plan_rows:
        print(f"[{job_id}] No plan found — run build_apply_plan.py first")
        return
    plan = plan_rows[0]

    job = sb_get(f"jobs?id=eq.{job_id}&select=id,job_title,apply_url,company_id")[0]
    company = sb_get(f"companies?id=eq.{job['company_id']}&select=company_name,ats")[0]
    label = f"{company['company_name']} — {job['job_title']}"

    app_rows = sb_get(f"applications?job_id=eq.{job_id}&select=id")
    if app_rows:
        application_id = app_rows[0]["id"]
    else:
        application_id = sb_insert("applications", {"job_id": job_id, "status": "draft"})[0]["id"]

    context = await browser.new_context(ignore_https_errors=True)
    page = await context.new_page()
    filled_data = {}
    escalations = []
    technical_failures = []

    try:
        await page.goto(job["apply_url"], wait_until="domcontentloaded", timeout=30000)
        await page.wait_for_timeout(2000)

        for field in plan["fields"]:
            if field["field_name"] == "submit_button":
                continue
            if field.get("needs_escalation"):
                escalations.append(field)
                continue

            ok = await fill_field(page, field, resume_path)
            if not ok:
                new_selector = await repair_selector(page, field, client)
                if new_selector:
                    field["selector"] = new_selector
                    ok = await fill_field(page, field, resume_path)
                    if ok:
                        sb_upsert(
                            "ats_field_templates",
                            {"ats": company["ats"], "field_name": field["field_name"],
                             "selector": new_selector, "field_type": field["field_type"],
                             "verified_count": 1},
                            on_conflict="ats,field_name",
                        )
            if ok:
                filled_data[field["field_name"]] = field.get("value")
            else:
                technical_failures.append(field["field_name"])

        pre_submit_screenshot = await page.screenshot(full_page=True)

        if escalations or technical_failures:
            for f in escalations:
                sb_upsert(
                    "question_bank",
                    {"question_key": f["field_name"], "question_text": f["field_name"],
                     "answer_value": None, "category": "factual_needs_user",
                     "source_company": company["company_name"]},
                    on_conflict="question_key",
                )
            sb_patch("applications", f"id=eq.{application_id}", {
                "status": "blocked_on_question",
                "filled_data": filled_data,
                "notes": f"Blocked on: {[f['field_name'] for f in escalations]}. "
                         f"Technical failures (selector not found even after repair): {technical_failures}",
            })
            telegram_send_text(
                f"🚧 {label}\nBlocked on: {[f['field_name'] for f in escalations] + technical_failures}"
            )
            print(f"[{job_id}] Blocked — {len(escalations)} escalations, {len(technical_failures)} failures")
            return

        if await has_captcha(page):
            sb_patch("applications", f"id=eq.{application_id}", {
                "status": "blocked_on_captcha", "filled_data": filled_data,
                "notes": "CAPTCHA detected before submit — not attempting to solve/bypass.",
            })
            telegram_send_text(f"🤖 {label}\nBlocked on CAPTCHA — needs your manual submission.")
            print(f"[{job_id}] Blocked on CAPTCHA")
            return

        submit_field = next((f for f in plan["fields"] if f["field_name"] == "submit_button"), None)
        if submit_field and submit_field.get("selector"):
            await page.click(submit_field["selector"])
            await page.wait_for_timeout(3000)

        if await has_captcha(page):
            sb_patch("applications", f"id=eq.{application_id}", {
                "status": "blocked_on_captcha", "filled_data": filled_data,
                "notes": "CAPTCHA appeared after clicking Submit — not attempting to solve/bypass.",
            })
            telegram_send_text(f"🤖 {label}\nCAPTCHA blocked the actual submit — needs your manual click.")
            print(f"[{job_id}] CAPTCHA blocked submit")
            return

        confirmation_screenshot = await page.screenshot(full_page=True)
        upload_storage("application-screenshots", f"{job_id}-filled.png", pre_submit_screenshot, "image/png")
        upload_storage("application-screenshots", f"{job_id}-confirmed.png", confirmation_screenshot, "image/png")

        sb_patch("applications", f"id=eq.{application_id}", {
            "status": "submitted",
            "filled_data": filled_data,
            "confirmation_screenshot_url": f"{job_id}-confirmed.png",
            "submitted_at": "now()",
        })
        telegram_send_photo(
            confirmation_screenshot,
            f"✅ {label}\nSubmitted. Tap to give feedback.",
            application_id=application_id,
        )
        print(f"[{job_id}] Submitted successfully")

    except Exception as e:
        sb_patch("applications", f"id=eq.{application_id}", {
            "status": "blocked_on_technical_error",
            "filled_data": filled_data,
            "notes": f"Executor error: {e}",
        })
        telegram_send_text(f"⚠️ {label}\nExecutor error: {e}")
        print(f"[{job_id}] ERROR: {e}")
    finally:
        await context.close()


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
    if len(sys.argv) < 2:
        print("Usage: python3 execute_apply_plan.py <job_id> [<job_id> ...]")
        sys.exit(1)
    asyncio.run(main(sys.argv[1:]))
