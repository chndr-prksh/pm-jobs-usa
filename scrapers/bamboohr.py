"""
BambooHR scraper.
ats_config fields:
  slug         - Company subdomain on bamboohr.com, e.g. "splitit"
  search_text  - optional, defaults to "product manager"

Note: BambooHR's public API has no server-side search or country filter.
We fetch all open roles and filter by title keywords client-side.
"""

import requests

PM_KEYWORDS = [
    "product manager", "product management", "head of product",
    "vp of product", "director of product", "chief product officer",
    "group pm", "principal pm", "staff pm",
]

def _is_pm_role(title: str) -> bool:
    t = title.lower()
    return any(kw in t for kw in PM_KEYWORDS)

BASE_HEADERS = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"}


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    slug = cfg["slug"]

    url = f"https://{slug}.bamboohr.com/careers/list"
    resp = requests.get(url, headers=BASE_HEADERS, timeout=30)
    resp.raise_for_status()
    data = resp.json()

    jobs = []
    for j in data.get("result", []):
        title = j.get("jobOpeningName", "")

        # No server-side search — filter PM roles by title
        if not _is_pm_role(title):
            continue

        loc = j.get("atsLocation", {}) or {}
        country = (loc.get("country") or "").strip()
        state = (loc.get("state") or loc.get("province") or "").strip()
        city = (loc.get("city") or "").strip()

        # Skip non-US if country is explicitly set to something else
        if country and country.lower() not in ("united states", "us", "usa"):
            continue

        location_str = ", ".join(filter(None, [city, state, country or "US"]))

        dept = j.get("departmentLabel") or None
        job_id = str(j["id"])
        apply_url = f"https://{slug}.bamboohr.com/careers/{job_id}"

        jobs.append({
            "external_job_id": job_id,
            "job_title": title,
            "department": dept,
            "location": location_str,
            "apply_url": apply_url,
            "posted_date": None,
            "raw": j,
        })

    return jobs
