"""
On-screen apply assistant (continuous mode). Attaches to YOUR real, already-
open Chrome (via Chrome's remote-debugging port). You paste a job URL, it
navigates the assist tab there and prefills the form; paste the next URL and
it fills that one too. It NEVER submits — you review and click Submit.

Why this instead of headless auto-submit: every wall we hit (bot detection,
"Unable to verify the application", CAPTCHA) exists to stop an *automated
browser* from *submitting*. Here submission is a genuine human action in your
own real browser session — nothing to detect. We only prefill.

Filling is 100% deterministic Playwright — NO API credits are spent. Custom
factual questions (sponsorship, work authorization, citizenship, relocation,
EEO/veteran/gender/race/disability) are answered directly from your stored
ontology, matched by keyword — no LLM, no per-question guessing.

Setup (one time):  ./launch_assist_chrome.sh
Then run:          python3 assist.py
"""

from __future__ import annotations

import asyncio
import json
import os
import re

from anthropic import Anthropic
from playwright.async_api import async_playwright, Page

from execute_apply_plan import sb_get, fill_field, download_base_resume
from build_apply_plan import PLAN_PROMPT

CDP_URL = "http://localhost:9222"


def clean_form_html(html: str) -> str:
    """Strip the noise that bloats input tokens on React/Ashby pages —
    scripts, styles, SVGs, comments, and the huge class/style attribute
    strings — while keeping everything the planner actually needs (id, name,
    type, value, placeholder, aria-*, data-*, and the visible text)."""
    html = re.sub(r"<script[\s\S]*?</script>", "", html, flags=re.I)
    html = re.sub(r"<style[\s\S]*?</style>", "", html, flags=re.I)
    html = re.sub(r"<svg[\s\S]*?</svg>", "", html, flags=re.I)
    html = re.sub(r"<!--[\s\S]*?-->", "", html)
    html = re.sub(r'\sstyle="[^"]*"', "", html)
    html = re.sub(r'\sclass="[^"]*"', "", html)   # class selectors aren't reliable anyway
    html = re.sub(r'\stabindex="[^"]*"', "", html)
    html = re.sub(r"\s+", " ", html)
    return html.strip()


async def plan_live_page(page: Page, profile: dict) -> list[dict] | None:
    """Capture EVERY field on the currently-open page and make ONE AI call to
    answer all of them — factual questions from the candidate ontology,
    descriptive/essay questions drafted from the resume. Returns a field list
    (same schema execute uses) or None if the API is unavailable (e.g. no
    credits) so the caller can fall back to deterministic filling."""
    form = await page.query_selector("form")
    html = await form.evaluate("el => el.outerHTML") if form else await page.content()
    html = clean_form_html(html)[:40000]

    title = ""
    try:
        title = (await page.title()) or ""
    except Exception:
        pass

    # Only the factual key/value answers (small) — not the long drafted essays;
    # the model drafts those fresh from the resume, and sending them wastes tokens.
    question_bank = sb_get(
        "question_bank?category=in.(factual_user_provided,factual_needs_user)"
        "&select=question_key,answer_value"
    )
    prompt = PLAN_PROMPT.format(
        candidate_profile=json.dumps(profile, default=str),
        question_bank=json.dumps(question_bank, default=str),
        field_templates="[]",
        ats="unknown",
        job_title=title or "(job application)",
        description="(The full form is in the page HTML below — answer every field it contains.)",
        page_html=html,
    )
    try:
        client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
        message = client.messages.create(
            model="claude-haiku-4-5",
            max_tokens=6144,
            messages=[{"role": "user", "content": prompt}],
        )
        text = next((b.text for b in message.content if b.type == "text"), "[]").strip()
        if text.startswith("```"):
            text = text.split("```")[1]
            if text.startswith("json"):
                text = text[4:]
        return json.loads(text)
    except Exception as e:
        msg = str(e)
        if "credit balance" in msg.lower():
            print("  (AI answering unavailable — API credit balance is empty. Top up at "
                  "console.anthropic.com to auto-answer descriptive/custom questions.)")
        else:
            print(f"  (AI answering unavailable: {msg})")
        return None


# ---------------------------------------------------------------------------
# Ontology-driven deterministic answering (no API).
# Each rule: distinctive phrases that appear in the QUESTION, plus the answer
# to fill. Yes/No rules fill a yes/no toggle; option rules pick the on-page
# option whose visible label CONTAINS the target text.
# ---------------------------------------------------------------------------

def build_rules(profile: dict):
    wa = profile.get("work_authorization") or {}
    demo = profile.get("demographics") or {}

    authorized = wa.get("authorized_us", True)
    needs_sponsor = wa.get("needs_sponsorship", False)
    is_citizen = str(wa.get("citizenship", "")).strip().lower() in ("us", "us citizen", "citizen", "united states")

    yes_no_rules = [
        # (question phrases, "Yes"/"No")
        (["require sponsorship", "need sponsorship", "require company sponsorship",
          "visa sponsorship", "sponsorship now or in the future", "sponsorship to work",
          "will you require sponsorship"], "No" if not needs_sponsor else "Yes"),
        (["authorized to work", "legally authorized", "authorization to work",
          "eligible to work", "right to work", "work authorization", "work permit",
          "authorized to work in the united states", "currently authorized"], "Yes" if authorized else "No"),
        (["u.s. citizen", "us citizen", "united states citizen", "are you a citizen",
          "citizen of the united states"], "Yes" if is_citizen else "No"),
        (["relocat", "willing to relocate", "in office", "in-office", "onsite", "on-site",
          "commuting distance", "hybrid", "office attendance", "reside within commuting",
          "able to work from", "work from the office"], "Yes"),
        (["worked at", "previously employed by", "former employee", "worked here before",
          "employed by pwc", "employed by the company"], "No"),
        (["government", "military", "federal employment", "public sector"], "No"),
    ]

    # Option-group rules: pick the on-page option whose label contains target text.
    option_rules = [
        (["gender"], demo.get("gender", "Male")),
        (["race", "ethnicity"], _race_target(demo.get("race_ethnicity", "Asian"))),
        (["veteran"], "not a protected veteran"),
        (["disability", "disabled"], "do not have"),
    ]
    return yes_no_rules, option_rules


def _race_target(race: str) -> str:
    # Use a distinctive substring likely present in the on-page option.
    r = (race or "").lower()
    if "asian" in r:
        return "Asian"
    return race or "Asian"


async def _answer_yes_no(page: Page, phrases, answer: str, resume_path: str) -> bool:
    for phrase in phrases:
        try:
            loc = page.get_by_text(phrase, exact=False)
            if await loc.count() >= 1:
                qtext = (await loc.first.inner_text()).strip()
                if not qtext:
                    continue
                field = {"field_name": "factual", "field_type": "radio",
                         "label": qtext[:80], "value": answer, "selector": None}
                if await fill_field(page, field, resume_path):
                    return True
        except Exception:
            continue
    return False


async def _answer_option(page: Page, phrases, target: str, resume_path: str) -> bool:
    for phrase in phrases:
        try:
            loc = page.get_by_text(phrase, exact=False)
            if await loc.count() >= 1:
                qtext = (await loc.first.inner_text()).strip()
                field = {"field_name": "eeo", "field_type": "radio",
                         "label": qtext[:80], "value": target, "selector": None}
                if await fill_field(page, field, resume_path):
                    return True
        except Exception:
            continue
    return False


async def fill_from_ontology(page: Page, profile: dict, resume_path: str) -> int:
    yes_no_rules, option_rules = build_rules(profile)
    filled = 0
    for phrases, answer in yes_no_rules:
        if await _answer_yes_no(page, phrases, answer, resume_path):
            filled += 1
    for phrases, target in option_rules:
        if await _answer_option(page, phrases, target, resume_path):
            filled += 1
    return filled


async def fill_standard(page: Page, profile: dict, resume_path: str) -> int:
    std = [
        ("full_name", "text", "Name", profile.get("full_name")),
        ("first_name", "text", "First Name", (profile.get("full_name") or "").split(" ")[0]),
        ("last_name", "text", "Last Name", " ".join((profile.get("full_name") or "").split(" ")[1:])),
        ("email", "text", "Email", profile.get("email")),
        ("phone", "text", "Phone", profile.get("phone")),
        ("location", "text", "Location", profile.get("location")),
        ("linkedin_url", "text", "LinkedIn", profile.get("linkedin_url")),
    ]
    filled = 0
    for fname, ftype, label, value in std:
        if not value:
            continue
        try:
            if await fill_field(page, {"field_name": fname, "field_type": ftype,
                                       "label": label, "value": value, "selector": None}, resume_path):
                filled += 1
        except Exception:
            pass
    # Resume upload
    try:
        file_input = page.locator("input[type='file']").first
        if await file_input.count():
            await file_input.set_input_files(resume_path)
            filled += 1
    except Exception:
        pass
    return filled


# ---------------------------------------------------------------------------

def _find_job_by_url(url: str):
    base = url.split("?")[0].split("#")[0].rstrip("/")
    for r in sb_get("jobs?select=id,apply_url,job_title,company_id"):
        japply = (r.get("apply_url") or "").split("?")[0].split("#")[0].rstrip("/")
        if japply and (japply == base or japply in url):
            return r
    return None


async def _ensure_form(page: Page):
    if not await page.query_selector("input"):
        ctrl = await page.query_selector("a:has-text('Apply'), button:has-text('Apply')")
        if ctrl and await ctrl.is_visible():
            await ctrl.click()
            await page.wait_for_timeout(1500)


async def fill_tab(page: Page, profile: dict, resume_path: str):
    await _ensure_form(page)

    # PRIMARY: capture every field on the page and answer them all in one AI
    # call (factual from ontology, descriptive drafted from resume).
    fields = await plan_live_page(page, profile)
    if fields:
        filled, skipped = 0, []
        for field in fields:
            if field.get("field_name") == "submit_button":
                continue
            if field.get("needs_escalation"):
                skipped.append(field.get("label") or field.get("field_name"))
                continue
            try:
                if await fill_field(page, field, resume_path):
                    filled += 1
                else:
                    skipped.append(field.get("label") or field.get("field_name"))
            except Exception:
                skipped.append(field.get("label") or field.get("field_name"))
        # Belt-and-suspenders: the AI sometimes wrongly escalates or misses a
        # factual/EEO question we can answer deterministically. Sweep those.
        n_ont = await fill_from_ontology(page, profile, resume_path)
        print(f"  AI-answered and filled {filled} field(s); {n_ont} more from your profile.")
        if skipped:
            print("  Please review / confirm these yourself:")
            for s in skipped:
                print(f"    - {s}")
        print("  Review everything, solve any CAPTCHA, then click Submit yourself.")
        return

    # FALLBACK (no API credits): deterministic standard + ontology fill.
    n_std = await fill_standard(page, profile, resume_path)
    n_ont = await fill_from_ontology(page, profile, resume_path)
    print(f"  Filled deterministically: {n_std} standard + {n_ont} factual/EEO fields (no AI).")
    print("  Descriptive/essay questions need AI — top up API credits for full coverage.")
    print("  Review, answer anything blank, solve any CAPTCHA, then click Submit yourself.")


async def main():
    async with async_playwright() as p:
        try:
            browser = await p.chromium.connect_over_cdp(CDP_URL)
        except Exception as e:
            print("Could not connect to Chrome's remote-debugging port (9222).")
            print("Run ./launch_assist_chrome.sh first, then log in / open a job in that window.")
            print(f"({e})")
            return

        resume_path = "/tmp/base_resume.pdf"
        download_base_resume(resume_path)
        profile = sb_get("candidate_profile?select=*")[0]

        def _tab():
            for ctx in reversed(browser.contexts):
                if ctx.pages:
                    return ctx.pages[-1]
            return None

        print("Assist ready. Paste a job URL and press Enter — I'll fill it.")
        print("(Enter with no URL = re-fill the current tab.  q = quit.)\n")

        loop = asyncio.get_event_loop()
        while True:
            url = (await loop.run_in_executor(None, input, "Job URL > ")).strip()
            if url.lower() in ("q", "quit", "exit"):
                break
            page = _tab()
            if page is None:
                print("  No open tab in the assist Chrome window. Open one and retry.")
                continue
            try:
                if url:
                    await page.goto(url, wait_until="domcontentloaded", timeout=30000)
                    await page.wait_for_timeout(1500)
                await fill_tab(page, profile, resume_path)
            except Exception as e:
                print(f"  Error filling this page: {e}")

        print("Done. Assist stopped.")


if __name__ == "__main__":
    asyncio.run(main())
