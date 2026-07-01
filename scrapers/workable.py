"""
Workable scraper.
ats_config fields:
  slug  - Workable account slug, e.g. "huggingface"
"""

import requests

BASE_HEADERS = {
    "User-Agent": "Mozilla/5.0",
    "Content-Type": "application/json",
}


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    slug = cfg["slug"]
    search_text = cfg.get("search_text", "product manager")

    url = f"https://apply.workable.com/api/v3/accounts/{slug}/jobs"
    payload = {
        "query": search_text,
        "location": [],
        "remote": None,
        "workplace": None,
        "department": None,
    }

    resp = requests.post(url, json=payload, headers=BASE_HEADERS, timeout=30)
    resp.raise_for_status()
    data = resp.json()

    jobs = []
    for j in data.get("results", []):
        # Filter to US only
        loc = j.get("location", {})
        country_code = loc.get("countryCode", "")
        # Also check multi-location list
        locations = j.get("locations", [])
        us_location = (
            country_code.upper() == "US"
            or any(l.get("countryCode", "").upper() == "US" for l in locations)
        )
        if not us_location:
            continue

        city = loc.get("city", "")
        region = loc.get("region", "")
        location_str = ", ".join(filter(None, [city, region, "US"]))

        dept = j.get("department", [])
        dept_str = dept[0] if dept else None

        posted_raw = j.get("published", "")
        posted_date = posted_raw[:10] if posted_raw else None

        shortcode = j.get("shortcode", "")
        apply_url = f"https://apply.workable.com/{slug}/j/{shortcode}/"

        jobs.append({
            "external_job_id": shortcode,
            "job_title": j["title"],
            "department": dept_str,
            "location": location_str,
            "apply_url": apply_url,
            "posted_date": posted_date,
            "raw": j,
        })

    return jobs
