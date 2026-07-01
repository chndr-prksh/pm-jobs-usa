"""
SmartRecruiters scraper.
ats_config fields:
  slug  - Company identifier on SmartRecruiters, e.g. "HireVue"
"""

import requests

BASE_HEADERS = {"User-Agent": "Mozilla/5.0"}
PAGE_SIZE = 100


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    slug = cfg["slug"]
    search_text = cfg.get("search_text", "product manager")

    url = f"https://api.smartrecruiters.com/v1/companies/{slug}/postings"
    jobs = []
    offset = 0

    while True:
        params = {
            "q": search_text,
            "country": "us",
            "limit": PAGE_SIZE,
            "offset": offset,
        }
        resp = requests.get(url, params=params, headers=BASE_HEADERS, timeout=30)
        resp.raise_for_status()
        data = resp.json()

        content = data.get("content", [])
        if not content:
            break

        for j in content:
            loc = j.get("location", {})
            city = loc.get("city", "")
            region = loc.get("region", "")
            location_str = ", ".join(filter(None, [city, region, "US"]))

            dept = j.get("department", {})
            dept_str = dept.get("label") if dept else None

            posted_raw = j.get("releasedDate", "")
            posted_date = posted_raw[:10] if posted_raw else None

            job_id = j["id"]
            apply_url = f"https://jobs.smartrecruiters.com/{slug}/{job_id}"

            jobs.append({
                "external_job_id": job_id,
                "job_title": j["name"],
                "department": dept_str,
                "location": location_str,
                "apply_url": apply_url,
                "posted_date": posted_date,
                "raw": j,
            })

        total = data.get("totalFound", 0)
        offset += PAGE_SIZE
        if offset >= total:
            break

    return jobs
