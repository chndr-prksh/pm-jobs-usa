import requests
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from utils import is_us_location

BASE_URL = "https://boards-api.greenhouse.io/v1/boards/{slug}/jobs?content=true"
HEADERS = {"User-Agent": "Mozilla/5.0"}

def fetch(company: dict) -> list[dict]:
    slug = company["ats_config"]["slug"]
    response = requests.get(BASE_URL.format(slug=slug), headers=HEADERS, timeout=30)
    response.raise_for_status()
    data = response.json()

    jobs = []
    for job in data.get("jobs", []):
        location = job.get("location", {}).get("name")
        if not is_us_location(location):
            continue
        jobs.append({
            "external_job_id": str(job["id"]),
            "job_title": job["title"],
            "department": job.get("departments", [{}])[0].get("name") if job.get("departments") else None,
            "location": job.get("location", {}).get("name"),
            "apply_url": job["absolute_url"],
            "posted_date": (job.get("first_published") or "")[:10] or None,
            "raw": job,
        })

    return jobs
