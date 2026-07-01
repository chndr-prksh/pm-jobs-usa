"""
Pinpoint HQ scraper.
ats_config fields:
  slug         - company subdomain on pinpointhq.com, e.g. "ynab"
  search_text  - optional keyword filter on title (client-side), defaults to "product manager"

No server-side search or country filter — we fetch all jobs and filter client-side.
"""

import requests
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from utils import is_us_location

BASE_HEADERS = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"}

PM_KEYWORDS = [
    "product manager", "product management", "head of product",
    "vp of product", "director of product", "chief product officer",
    "group pm", "principal pm", "staff pm",
]


def _is_pm_role(title: str) -> bool:
    t = title.lower()
    return any(kw in t for kw in PM_KEYWORDS)


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    slug = cfg["slug"]

    url = f"https://{slug}.pinpointhq.com/jobs.json"
    resp = requests.get(url, headers=BASE_HEADERS, timeout=30)
    resp.raise_for_status()
    data = resp.json()

    jobs = []
    for j in data.get("data", []):
        title = j.get("title", "")
        if not _is_pm_role(title):
            continue

        loc = j.get("location", {})
        location_name = loc.get("name", "") if isinstance(loc, dict) else str(loc)

        if location_name and not is_us_location(location_name):
            continue

        dept = j.get("department", {})
        dept_str = dept.get("name") if isinstance(dept, dict) else None

        job_id = str(j["id"])
        path = j.get("path", f"/jobs/{job_id}")
        apply_url = f"https://{slug}.pinpointhq.com{path}"

        jobs.append({
            "external_job_id": job_id,
            "job_title": title,
            "department": dept_str,
            "location": location_name or "US",
            "apply_url": apply_url,
            "posted_date": None,
            "raw": j,
        })

    return jobs
