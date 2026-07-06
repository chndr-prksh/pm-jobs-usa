"""
Shared answer brain for the apply copilot — the single place that maps a
form field's visible label to the candidate's answer, deterministically,
from the stored ontology (work_authorization / demographics / preferences /
identity). No API calls.

Used by both the DOM-fill loop (via the Claude-in-Chrome extension's
read_page + form_input) and, as a fallback source of truth, the vision path.

resolve(label, field_type) -> dict:
    {
      "value": <string answer or None>,
      "kind":  "identity" | "factual" | "eeo" | "descriptive" | "needs_user",
      "confidence": "high" | "none",
    }

- "high" confidence + a value  -> fill it deterministically, no AI/human.
- kind == "descriptive"        -> a written/essay answer; draft with AI.
- kind == "needs_user" or None -> stop and ask the human (salary, novel
                                   personal facts, anything not derivable).
"""

from __future__ import annotations

import re

from execute_apply_plan import sb_get


def load_profile() -> dict:
    return sb_get("candidate_profile?select=*")[0]


def _titlecase(s: str) -> str:
    # Profile names may be stored all-caps; forms look right title-cased.
    return " ".join(w.capitalize() for w in (s or "").split())


def _first_last(full_name: str):
    parts = (full_name or "").split()
    first = _titlecase(parts[0]) if parts else ""
    last = _titlecase(" ".join(parts[1:])) if len(parts) > 1 else ""
    return first, last


def _has(label: str, *phrases: str) -> bool:
    return any(p in label for p in phrases)


def resolve(label: str, field_type: str, profile: dict) -> dict:
    """Map one field label to an answer. field_type is a hint
    (text/select/radio/checkbox/file/textarea)."""
    if not label:
        return {"value": None, "kind": "needs_user", "confidence": "none"}
    L = label.strip().lower()

    wa = profile.get("work_authorization") or {}
    demo = profile.get("demographics") or {}
    first, last = _first_last(profile.get("full_name"))

    def high(value, kind):
        return {"value": value, "kind": kind, "confidence": "high"}

    # ---- Identity -------------------------------------------------------
    if _has(L, "preferred") and _has(L, "name"):
        return high(first, "identity")
    if _has(L, "first name") or L in ("first", "given name", "legal first name"):
        return high(first, "identity")
    if _has(L, "last name", "surname", "family name"):
        return high(last, "identity")
    if _has(L, "full name") or L == "name":
        return high(_titlecase(profile.get("full_name")), "identity")
    if _has(L, "email"):
        return high(profile.get("email"), "identity")
    if _has(L, "phone", "mobile", "cell"):
        return high(profile.get("phone"), "identity")
    if _has(L, "linkedin"):
        return high(profile.get("linkedin_url"), "identity")
    if _has(L, "github", "portfolio", "website", "personal site"):
        return high(profile.get("portfolio_url") or profile.get("linkedin_url"), "identity")
    if _has(L, "country"):
        return high("United States", "identity")
    if _has(L, "location", "city", "where are you", "current location", "address"):
        return high(profile.get("location"), "identity")

    # ---- Factual / work authorization ----------------------------------
    # Sponsorship / immigration support (order matters: check before generic auth)
    if _has(L, "sponsor", "immigration support", "immigration status", "visa support"):
        return high("No" if not wa.get("needs_sponsorship", False) else "Yes", "factual")
    if _has(L, "authorized to work", "authorization to work", "legally authorized",
            "eligible to work", "right to work", "work authorization", "work permit",
            "authorized to be employed", "without restriction"):
        return high("Yes" if wa.get("authorized_us", True) else "No", "factual")
    if _has(L, "citizen", "us person", "u.s. person"):
        is_citizen = str(wa.get("citizenship", "")).lower() in ("us", "us citizen", "citizen", "united states")
        return high("Yes" if is_citizen else "No", "factual")

    # Relocation / onsite / hybrid / commuting  -> always yes (preference)
    if _has(L, "relocat", "onsite", "on-site", "in office", "in-office", "commut",
            "hybrid", "office", "willing to work", "reside within", "able to work from"):
        return high("Yes", "factual")

    # Background check
    if _has(L, "background check", "background investigation"):
        return high("Yes", "factual")

    # Worked here before / prior employment at this company
    if _has(L, "worked at", "previously employed", "former employee", "worked here before",
            "employed by"):
        return high("No", "factual")
    if _has(L, "government", "military", "federal employment", "security clearance"):
        # Clearance questions are usually "do you have one" -> No; military history -> No
        return high("No", "factual")

    # ---- EEO / voluntary self-identification ---------------------------
    if _has(L, "hispanic", "latino"):
        race = str(demo.get("race_ethnicity", "")).lower()
        return high("No" if "hispanic" not in race and "latino" not in race else "Yes", "eeo")
    if _has(L, "gender", "sex ") or L == "sex":
        return high(demo.get("gender", "Male"), "eeo")
    if _has(L, "race", "ethnicity"):
        return high(demo.get("race_ethnicity", "Asian"), "eeo")
    if _has(L, "veteran"):
        return high("I am not a protected veteran", "eeo")
    if _has(L, "disab"):
        return high("No, I do not have a disability", "eeo")
    if _has(L, "pronoun"):
        return high(demo.get("pronouns", "He/Him"), "eeo")

    # ---- Genuinely personal / unknown -> ask the human -----------------
    # (checked before descriptive so a "compensation" textarea isn't drafted)
    if _has(L, "salary", "compensation", "expected pay", "desired pay",
            "rate expectation", "pay expectation", "notice period", "start date",
            "date of birth", "ssn", "social security"):
        return {"value": None, "kind": "needs_user", "confidence": "none"}

    # ---- Descriptive (write from resume) -------------------------------
    if field_type == "textarea" or _has(L, "why ", "describe", "tell us", "cover letter",
                                        "what makes you", "experience with", "how would you",
                                        "your approach"):
        return {"value": None, "kind": "descriptive", "confidence": "none"}

    return {"value": None, "kind": "needs_user", "confidence": "none"}
