"""
Uber careers — uses a public JSON API protected by Cloudflare.
Playwright opens the careers page to solve the CF challenge, then
calls the API via in-page fetch (same origin = no block).
"""

import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from scrapers.playwright_base import fetch_json

BASE_URL = "https://jobs.uber.com/en/jobs/"
API_URL = "https://jobs.uber.com/api/jobs/search/"
PAGE_SIZE = 100


def fetch(company: dict) -> list[dict]:
    jobs = []
    offset = 0

    while True:
        params = (
            f"?search=product+manager&locale=en&country=United+States"
            f"&limit={PAGE_SIZE}&offset={offset}"
        )
        data = fetch_json(
            BASE_URL,
            js_fetch_options={"api_url": API_URL + params},
        )

        results = data if isinstance(data, list) else (
            data.get("results") or data.get("value") or data.get("jobs") or []
        )
        if not results:
            break

        for job in results:
            locations = job.get("Locations") or []
            us_locations = [
                loc for loc in locations
                if (loc.get("Country") or "").lower() in ("united states", "us", "usa")
            ]
            if not us_locations:
                continue

            location_str = ", ".join(
                f"{loc['City']}, {loc['Region']}"
                for loc in us_locations if loc.get("City")
            ) or "United States"

            urls = job.get("Urls") or []
            job_path = next((u["Url"] for u in urls if u.get("IsDefault")), urls[0]["Url"] if urls else "")
            apply_url = f"https://jobs.uber.com{job_path}" if job_path.startswith("/") else job_path

            posted_raw = job.get("DisplayDate", "")
            posted_date = posted_raw[:10] if posted_raw else None

            teams = job.get("Teams") or []
            department = teams[0] if teams else None

            jobs.append({
                "external_job_id": str(job["Id"]),
                "job_title": job["Title"],
                "department": department,
                "location": location_str,
                "apply_url": apply_url,
                "posted_date": posted_date,
                "raw": job,
            })

        if len(results) < PAGE_SIZE:
            break
        offset += PAGE_SIZE

    return jobs
