from datetime import datetime, timezone
import requests
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from utils import is_us_location

BASE_URL = "https://api.lever.co/v0/postings/{slug}?mode=json"
HEADERS = {"User-Agent": "Mozilla/5.0"}

def fetch(company: dict) -> list[dict]:
    slug = company["ats_config"]["slug"]
    response = requests.get(BASE_URL.format(slug=slug), headers=HEADERS, timeout=30)
    response.raise_for_status()
    data = response.json()

    if not isinstance(data, list):
        return []

    jobs = []
    for job in data:
        if not is_us_location(job.get("categories", {}).get("location")):
            continue
        categories = job.get("categories", {})
        created_at = job.get("createdAt")
        posted_date = (
            datetime.fromtimestamp(created_at / 1000, tz=timezone.utc).strftime("%Y-%m-%d")
            if created_at else None
        )
        jobs.append({
            "external_job_id": job["id"],
            "job_title": job["text"],
            "department": categories.get("department"),
            "location": categories.get("location"),
            "apply_url": job.get("hostedUrl", ""),
            "posted_date": posted_date,
            "raw": job,
        })

    return jobs
