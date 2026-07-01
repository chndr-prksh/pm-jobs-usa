"""
iCIMS / Jibe scraper.
These companies host their careers on iCIMS's Jibe platform, which exposes a
consistent public JSON API at {career_domain}/api/jobs.

ats_config fields:
  career_domain  - e.g. "careers.rivian.com"  (no https://)
  search_text    - optional, defaults to "product manager"
"""

import requests
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from utils import is_us_location

BASE_HEADERS = {"User-Agent": "Mozilla/5.0"}
PAGE_SIZE = 20


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    domain = cfg["career_domain"].rstrip("/")
    search_text = cfg.get("search_text", "product manager")

    base_url = f"https://{domain}/api/jobs"
    jobs = []
    page = 1

    while True:
        params = {
            "page": page,
            "sortBy": "relevance",
            "descending": "false",
            "internal": "false",
            "keyword": search_text,
        }
        resp = requests.get(base_url, params=params, headers=BASE_HEADERS, timeout=30)
        resp.raise_for_status()
        data = resp.json()

        raw_jobs = data.get("jobs", [])
        total = data.get("totalCount", 0)

        if not raw_jobs:
            break

        for item in raw_jobs:
            j = item.get("data", item)

            country_code = j.get("country_code", "")
            country = j.get("country", "")
            location_str = j.get("short_location") or j.get("full_location") or country

            # Filter to US only
            if country_code and country_code.upper() != "US":
                continue
            if not country_code and not is_us_location(location_str):
                continue

            dept = None
            if j.get("department"):
                dept = j["department"]
            elif j.get("categories"):
                dept = j["categories"][0].get("name")
            elif j.get("category"):
                cats = j["category"]
                dept = cats[0].strip() if cats else None

            posted_raw = j.get("posted_date", "")
            posted_date = posted_raw[:10] if posted_raw else None

            jobs.append({
                "external_job_id": str(j.get("req_id") or j.get("slug", "")),
                "job_title": j["title"],
                "department": dept,
                "location": location_str,
                "apply_url": j.get("apply_url", ""),
                "posted_date": posted_date,
                "raw": j,
            })

        # Stop if we've fetched all pages
        if page * PAGE_SIZE >= total:
            break
        page += 1

    return jobs
