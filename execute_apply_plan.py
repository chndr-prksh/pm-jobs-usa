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
import re
import sys

import requests
from anthropic import Anthropic
from dotenv import load_dotenv
from playwright.async_api import async_playwright, Page

from gmail_otp import fetch_otp_code

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
    # Prefer just the <form> HTML — some ATS pages (Lever especially) inline
    # huge amounts of unrelated markup before the form, and a naive prefix
    # truncation can cut the actual fields off entirely.
    form = await page.query_selector("form")
    html = await form.evaluate("el => el.outerHTML") if form else await page.content()
    html = html[:60000]

    label_hint = f" Its visible label/question text is: {field['label']!r}." if field.get("label") else ""
    value_hint = ""
    if field.get("field_type") in ("radio", "checkbox") and field.get("value"):
        value_hint = (
            f" This is a multi-option radio/checkbox group — we need the selector for the SPECIFIC "
            f"option whose visible text/value is exactly: {field['value']!r}. Do not return a selector "
            f"for a different option in the same group."
        )
    prompt = (
        f"Here is the current HTML of a job application form. I need the CSS selector for the "
        f"field '{field['field_name']}' (type: {field['field_type']}).{label_hint}{value_hint} "
        f"For radio/checkbox groups without a real <label for> association (common on Lever), "
        f"match on the input's own value attribute, e.g. input[name='...'][value='...']. "
        f"Return ONLY the selector as a plain string, no markdown, no explanation. "
        f"If the field genuinely doesn't exist on this page, return exactly: NONE\n\n"
        f"HTML:\n{html}"
    )
    message = client.messages.create(
        model="claude-sonnet-5",
        max_tokens=256,
        messages=[{"role": "user", "content": prompt}],
    )
    text = next((b.text for b in message.content if b.type == "text"), "NONE").strip()
    if text.startswith("```"):
        text = text.strip("`").strip()
        if text.lower().startswith("css"):
            text = text[3:].strip()
    return None if text == "NONE" else text


EXPECTED_TAGS = {
    "file": {"input"},
    "text": {"input", "textarea"},
    "textarea": {"textarea", "input"},
    "select": {"select"},
    "checkbox": {"input"},
    "radio": {"input"},
}


async def _resolve_locator(page: Page, field: dict):
    """Accessible-name-first field location: a label match survives CSS
    class/id churn across ATS redeploys, unlike a hardcoded selector. Falls
    back to the plan's CSS selector if no label was captured, it doesn't
    resolve to exactly one element, or (common with styled upload/dropdown
    widgets) the label wraps a container div rather than the real control."""
    label = field.get("label")
    ftype = field.get("field_type")
    if label:
        try:
            loc = page.get_by_label(label, exact=False)
            if await loc.count() == 1:
                tag = await loc.first.evaluate("el => el.tagName.toLowerCase()")
                if tag in EXPECTED_TAGS.get(ftype, {"input"}):
                    return loc.first
        except Exception:
            pass
    selector = field.get("selector")
    if selector:
        return page.locator(selector).first
    return None


async def _validate_fill(locator, ftype: str, value: str | None, intended_checked: bool | None = None) -> bool:
    """Read the field's actual value back and compare to what we intended —
    catches silent mismatches (e.g. select_option matching the wrong option)
    that don't raise an exception but also don't do what was asked."""
    if not value:
        return True
    try:
        if ftype in ("text", "textarea"):
            actual = await locator.input_value()
            actual_l, value_l = actual.strip().lower(), value.strip().lower()
            # Substring containment, not exact match — some fields (e.g. Lever's
            # location autocomplete) reformat the value after fill (adds ", USA"
            # etc.) without that being a real failure.
            return actual_l == value_l or value_l in actual_l or actual_l in value_l
        if ftype == "select":
            actual = await locator.input_value()
            return value.strip().lower() in actual.strip().lower() or actual.strip().lower() in value.strip().lower()
        if ftype in ("checkbox", "radio"):
            # Compare against whatever fill_field actually intended to do
            # (checked vs unchecked) — for a genuine multi-option radio group
            # "checking the option whose value is literally 'No'" is a
            # correct, checked=True outcome, not a failure.
            if intended_checked is None:
                return await locator.is_checked()
            return await locator.is_checked() == intended_checked
    except Exception:
        return True  # combobox/custom widgets don't expose input_value() — skip strict check
    return True


async def _check_locator(loc, check: bool = True):
    """check/uncheck, falling back to force=True for real-but-CSS-hidden
    native inputs (styled checkbox/radio widgets). force still acts on the
    same real control — it only skips Playwright's visibility gate."""
    action = loc.check if check else loc.uncheck
    try:
        await action(timeout=5000)
    except Exception:
        await action(timeout=5000, force=True)


async def _fill_choice(page: Page, locator, field: dict) -> bool:
    """Robust radio/checkbox filling — works even when the planner produced
    NO css selector (locator is None), because the reliable key here isn't a
    selector but the ACCESSIBLE NAME (visible label), which Playwright
    computes even without an explicit aria-label.

    Multi-option groups (Ashby EEO radios, Lever custom questions) can't be
    picked by value attribute — every option often shares name and value.
    A single yes/no toggle's accessible name is the QUESTION text (the
    field's label), and its answer polarity decides check vs uncheck."""
    ftype, value, label = field["field_type"], field.get("value"), field.get("label")
    if not value:
        return True

    # 1) Specific option in a multi-option group, matched by the OPTION's
    #    accessible name (i.e. value == the visible option label text).
    for exact in (True, False):
        try:
            opt = page.get_by_role(ftype, name=value, exact=exact)
            if await opt.count() == 1:
                await _check_locator(opt.first, check=True)
                if await opt.first.is_checked():
                    return True
        except Exception:
            pass

    negative = bool(re.search(r"\b(no|not|never|none|false)\b", value.strip().lower()))

    # 2) Single yes/no toggle located by the QUESTION's accessible name
    #    (the field label) — needed when there's no selector at all.
    if label:
        try:
            toggle = page.get_by_role(ftype, name=label, exact=False)
            if await toggle.count() == 1:
                await _check_locator(toggle.first, check=not negative)
                if await toggle.first.is_checked() == (not negative):
                    return True
        except Exception:
            pass

    # 2.4) Ashby-style yes/no toggle: rendered as two <button>Yes</button>
    #      <button>No</button> with a hidden checkbox as state holder — you
    #      must click the BUTTON, not the checkbox (force-checking the hidden
    #      input doesn't fire the widget's state change). Click the button
    #      whose text matches the answer polarity, nearest the question.
    if label:
        try:
            q = page.get_by_text(label[:60], exact=False).first
            if await q.count():
                target = "No" if negative else "Yes"
                btn = q.locator(f'xpath=following::button[normalize-space()="{target}"][1]')
                if await btn.count() >= 1:
                    await btn.first.click(timeout=5000)
                    cls = (await btn.first.get_attribute("class")) or ""
                    if "active" in cls.lower():
                        return True
        except Exception:
            pass

    # 2.5) Deterministic label-proximity (NO LLM): find the question text,
    #      then the nearest following checkbox/radio in DOM order. Only used
    #      when that input is a single toggle (one input of its name) — a
    #      multi-option group would already have matched in step 1.
    if label:
        try:
            q = page.get_by_text(label[:60], exact=False).first
            if await q.count():
                near = q.locator('xpath=following::input[@type="checkbox" or @type="radio"][1]')
                if await near.count() == 1:
                    nm = await near.first.get_attribute("name")
                    group = await page.locator(f"input[name='{nm}']").count() if nm else 1
                    if group == 1:
                        await _check_locator(near.first, check=not negative)
                        if await near.first.is_checked() == (not negative):
                            return True
        except Exception:
            pass

    # 3) Fall back to the resolved locator, if we have one.
    if locator is None:
        return False
    name = await locator.get_attribute("name")
    group_count = await page.locator(f"input[name='{name}']").count() if name else 1
    negative = bool(group_count == 1 and negative)
    await _check_locator(locator, check=not negative)
    return await _validate_fill(locator, ftype, value, intended_checked=not negative)


async def _fill_text(page: Page, locator, value: str | None) -> bool:
    """Fill a text field. If it's an autocomplete/typeahead combobox
    (location, country, school, etc.) — type the value, wait for the
    suggestion list, and click the matching option; fall back to keyboard
    ArrowDown+Enter to accept the first suggestion. Plain text fields just
    get filled."""
    if value is None:
        value = ""
    role = await locator.get_attribute("role")
    aria_auto = await locator.get_attribute("aria-autocomplete")
    aria_pop = await locator.get_attribute("aria-haspopup")
    is_combo = role == "combobox" or bool(aria_auto) or aria_pop in ("listbox", "true")

    if not is_combo or not value:
        await locator.fill(value)
        return True

    # Typeahead: type, then pick a suggestion.
    await locator.click()
    await locator.fill("")
    await locator.type(value, delay=20)
    await page.wait_for_timeout(700)

    # Prefer an option matching the first token of the value (e.g. the city).
    key = value.split(",")[0].strip()
    try:
        opt = page.get_by_role("option", name=re.compile(re.escape(key), re.I)).first
        await opt.wait_for(timeout=2500)
        await opt.click()
        return True
    except Exception:
        pass
    # Fallback: accept the highlighted/first suggestion via keyboard.
    try:
        await locator.press("ArrowDown")
        await locator.press("Enter")
    except Exception:
        pass
    return True


async def _locate_by_label(page: Page, field: dict):
    """Last-resort locator for text/select fields the planner left without a
    selector: match a combobox or input by the question label, or the input
    nearest the label text."""
    label = field.get("label")
    if not label:
        return None
    for cand in (
        page.get_by_role("combobox", name=label, exact=False),
        page.get_by_label(label, exact=False),
    ):
        try:
            if await cand.count() >= 1:
                return cand.first
        except Exception:
            pass
    # Proximity: find the element showing the label text, then the nearest
    # following control — preferring a combobox (typeahead) over a plain input.
    try:
        texts = page.get_by_text(label[:40], exact=False)
        n = min(await texts.count(), 5)
        for i in range(n):
            src = texts.nth(i)
            for xp in (
                'xpath=following::input[@role="combobox"][1]',
                "xpath=following::input[1]",
                "xpath=following::textarea[1]",
            ):
                cand = src.locator(xp)
                if await cand.count():
                    return cand.first
    except Exception:
        pass
    return None


async def _is_combobox(locator) -> bool:
    try:
        role = await locator.get_attribute("role")
        if role == "combobox":
            return True
        aria_auto = await locator.get_attribute("aria-autocomplete")
        aria_pop = await locator.get_attribute("aria-haspopup")
        tag = await locator.evaluate("e => e.tagName.toLowerCase()")
        return tag != "select" and (bool(aria_auto) or aria_pop in ("listbox", "true"))
    except Exception:
        return False


async def fill_field(page: Page, field: dict, resume_path: str) -> bool:
    ftype, value = field["field_type"], field.get("value")
    locator = await _resolve_locator(page, field)
    # Radio/checkbox can be filled by accessible name alone, so they don't
    # require a resolved css selector — route them before the None bail-out.
    if ftype in ("checkbox", "radio"):
        try:
            return await _fill_choice(page, locator, field)
        except Exception:
            return False
    # Text/select can also be found by label when the planner gave no selector
    # (common for typeahead location/country comboboxes the planner calls "select").
    if locator is None and ftype in ("text", "textarea", "select"):
        locator = await _locate_by_label(page, field)
    if locator is None:
        return False
    try:
        if ftype == "file":
            await locator.set_input_files(resume_path)
        elif ftype in ("text", "textarea"):
            return await _fill_text(page, locator, value)
        elif ftype == "select":
            if not value:
                return True  # optional select, no value planned — leave at default
            # A "select" that's really a typeahead combobox (Ashby/Lever
            # location, country) must be typed-and-picked, not select_option'd.
            if await _is_combobox(locator):
                return await _fill_text(page, locator, value)
            try:
                await locator.select_option(value=value)
            except Exception:
                try:
                    await locator.select_option(label=value)
                except Exception:
                    try:
                        await locator.select_option(label=re.compile(re.escape(value), re.I))
                    except Exception:
                        # Not a native <select> — likely a React-Select style combobox
                        # (text input + role=option listbox). Type and pick the match.
                        await locator.click()
                        await locator.fill(value)
                        option = page.get_by_role("option", name=re.compile(re.escape(value), re.I)).first
                        await option.wait_for(timeout=5000)
                        await option.click()
        elif ftype == "button":
            pass  # submit_button is clicked separately, not "filled"
        else:
            return True

        return await _validate_fill(locator, ftype, value)
    except Exception:
        return False


CAPTCHA_SELECTORS = [
    # reCAPTCHA's actual challenge frame (puzzle UI) — NOT "anchor", which is
    # just the passive invisible badge present on nearly every page load.
    "iframe[src*='bframe']",
    "iframe[src*='hcaptcha.com/captcha']",
    "iframe[src*='hcaptcha']",
    "div#h-captcha",
    "div.h-captcha",
    "iframe[src*='challenges.cloudflare.com']",
]

OTP_MARKERS = ["verification code was sent", "security code", "enter the"]


async def has_captcha(page: Page) -> bool:
    """Check for an actually-rendered CHALLENGE widget — not the passive
    invisible reCAPTCHA badge (iframe src contains 'anchor') that ships on
    nearly every Greenhouse page whether or not a challenge is ever
    triggered. Presence (not is_visible()) is checked for the hCaptcha
    checkbox widget specifically — it can intercept clicks on the submit
    button while Playwright's is_visible() still reports it hidden."""
    for sel in CAPTCHA_SELECTORS:
        if await page.query_selector(sel):
            return True
    return False


async def has_email_otp(page: Page) -> bool:
    """Detect Greenhouse's email-based 'confirm you're human' OTP step.
    This is not a bot-fingerprinting challenge — it verifies the applicant
    controls the email on the application, which the real applicant does."""
    content = (await page.content()).lower()
    return any(marker in content for marker in OTP_MARKERS)


async def fill_email_otp(page: Page, code: str) -> bool:
    """Fill an 8-character OTP split across individual single-char boxes."""
    try:
        boxes = await page.query_selector_all("input")
        candidates = [b for b in boxes if await b.is_visible()]
        # Narrow to short-maxlength boxes typical of OTP UIs, in DOM order.
        otp_boxes = []
        for b in candidates:
            maxlen = await b.get_attribute("maxlength")
            if maxlen and int(maxlen) <= 2:
                otp_boxes.append(b)
        if len(otp_boxes) >= len(code):
            for box, ch in zip(otp_boxes, code):
                await box.fill(ch)
            return True
        # Fallback: a single input accepting the whole code at once.
        if len(candidates) == 1:
            await candidates[0].fill(code)
            return True
        return False
    except Exception:
        return False


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

        # Ashby/Lever land on a job description page — the form only renders
        # after clicking through an "Apply" control (Greenhouse shows it directly).
        if not await page.query_selector("input"):
            apply_control = await page.query_selector("a:has-text('Apply'), button:has-text('Apply')")
            if apply_control and await apply_control.is_visible():
                await apply_control.click()
                await page.wait_for_timeout(2000)

        templates = {
            t["field_name"]: t["selector"]
            for t in sb_get(f"ats_field_templates?ats=eq.{company['ats']}&select=field_name,selector")
        }

        for field in plan["fields"]:
            if field["field_name"] == "submit_button":
                continue
            if field.get("needs_escalation"):
                escalations.append(field)
                continue

            # Prefer a live, previously-verified selector over the plan's cached one —
            # this is what actually closes the self-healing loop across runs.
            if field["field_name"] in templates:
                field["selector"] = templates[field["field_name"]]

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
                # A field fill can fail because a CAPTCHA widget is already
                # rendered on the page and intercepting clicks on it (seen on
                # Lever) — that's a CAPTCHA block, not a broken selector, and
                # must be classified as such rather than lumped in with
                # genuine technical failures.
                if await has_captcha(page):
                    sb_patch("applications", f"id=eq.{application_id}", {
                        "status": "blocked_on_captcha", "filled_data": filled_data,
                        "notes": f"CAPTCHA widget intercepted clicks while filling '{field['field_name']}' "
                                 f"— not attempting to solve/bypass.",
                    })
                    sb_insert("captcha_incidents", {
                        "company_id": job["company_id"], "ats": company["ats"], "job_id": job_id,
                    })
                    telegram_send_text(
                        f"🤖 {label}\nCAPTCHA blocked field filling — needs your manual submission.\n"
                        f"Run: python3 resume_captcha.py {job_id}"
                    )
                    print(f"[{job_id}] CAPTCHA intercepted field filling")
                    return
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
            sb_insert("captcha_incidents", {
                "company_id": job["company_id"], "ats": company["ats"], "job_id": job_id,
            })
            telegram_send_text(
                f"🤖 {label}\nBlocked on CAPTCHA — needs your manual submission.\n"
                f"Run: python3 resume_captcha.py {job_id}"
            )
            print(f"[{job_id}] Blocked on CAPTCHA")
            return

        submit_field = next((f for f in plan["fields"] if f["field_name"] == "submit_button"), None)
        submit_selector = (submit_field or {}).get("selector") or templates.get("submit_button")
        if not submit_selector:
            # Cheap deterministic guess before spending an LLM call — most ATS
            # forms use a plain type=submit button, and the repair call's
            # truncated HTML snapshot often cuts off before reaching it on
            # long pages anyway.
            fallback = await page.query_selector("button[type='submit']")
            if fallback and await fallback.is_visible():
                submit_selector = "button[type='submit']"
        if not submit_selector:
            submit_selector = await repair_selector(page, {"field_name": "submit_button", "field_type": "button"}, client)
            if submit_selector:
                sb_upsert(
                    "ats_field_templates",
                    {"ats": company["ats"], "field_name": "submit_button",
                     "selector": submit_selector, "field_type": "button", "verified_count": 1},
                    on_conflict="ats,field_name",
                )
        if not submit_selector:
            sb_patch("applications", f"id=eq.{application_id}", {
                "status": "blocked_on_technical_error",
                "filled_data": filled_data,
                "notes": "Could not locate a submit button selector — not marking as submitted.",
            })
            telegram_send_text(f"⚠️ {label}\nCouldn't find the submit button — needs manual review.")
            print(f"[{job_id}] No submit button selector found")
            return

        try:
            await page.click(submit_selector, timeout=10000)
        except Exception:
            # A click that times out/gets intercepted is very often a CAPTCHA
            # widget overlapping the button (seen on Lever) even when our
            # pre-click check missed it — treat as a CAPTCHA block, not a
            # generic technical error, if one is now detectable.
            if await has_captcha(page):
                sb_patch("applications", f"id=eq.{application_id}", {
                    "status": "blocked_on_captcha", "filled_data": filled_data,
                    "notes": "CAPTCHA widget intercepted the Submit click — not attempting to solve/bypass.",
                })
                sb_insert("captcha_incidents", {
                    "company_id": job["company_id"], "ats": company["ats"], "job_id": job_id,
                })
                telegram_send_text(
                    f"🤖 {label}\nCAPTCHA blocked the submit click — needs your manual click.\n"
                    f"Run: python3 resume_captcha.py {job_id}"
                )
                print(f"[{job_id}] CAPTCHA intercepted submit click")
                return
            raise
        await page.wait_for_timeout(3000)

        if await has_captcha(page):
            sb_patch("applications", f"id=eq.{application_id}", {
                "status": "blocked_on_captcha", "filled_data": filled_data,
                "notes": "CAPTCHA appeared after clicking Submit — not attempting to solve/bypass.",
            })
            sb_insert("captcha_incidents", {
                "company_id": job["company_id"], "ats": company["ats"], "job_id": job_id,
            })
            telegram_send_text(
                f"🤖 {label}\nCAPTCHA blocked the actual submit — needs your manual click.\n"
                f"Run: python3 resume_captcha.py {job_id}"
            )
            print(f"[{job_id}] CAPTCHA blocked submit")
            return

        if await has_email_otp(page):
            code = fetch_otp_code(sender_hint=company["ats"]) or fetch_otp_code(sender_hint="verification")
            if code and await fill_email_otp(page, code):
                # Re-click submit if the OTP screen has its own confirm button,
                # otherwise the original submit control re-validates the form.
                otp_submit = await page.query_selector("button:has-text('Submit')")
                if otp_submit and await otp_submit.is_visible():
                    await otp_submit.click()
                    await page.wait_for_timeout(3000)
            else:
                sb_patch("applications", f"id=eq.{application_id}", {
                    "status": "blocked_on_verification", "filled_data": filled_data,
                    "notes": "Email verification code required and could not be retrieved automatically.",
                })
                telegram_send_text(f"📧 {label}\nEmail verification code needed — couldn't auto-retrieve it.")
                print(f"[{job_id}] Blocked on email OTP")
                return

        confirmation_screenshot = await page.screenshot(full_page=True)
        upload_storage("application-screenshots", f"{job_id}-filled.png", pre_submit_screenshot, "image/png")
        upload_storage("application-screenshots", f"{job_id}-confirmed.png", confirmation_screenshot, "image/png")

        sb_patch("applications", f"id=eq.{application_id}", {
            "status": "submitted",
            "filled_data": filled_data,
            "confirmation_screenshot_url": f"{job_id}-confirmed.png",
            "submitted_at": "now()",
            "notes": None,
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
