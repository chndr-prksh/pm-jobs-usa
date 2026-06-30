import requests

BASE_URL = "https://api.ashbyhq.com/posting-api/job-board/{slug}"
HEADERS = {"User-Agent": "Mozilla/5.0"}

def fetch(company: dict) -> list[dict]:
    slug = company["ats_config"]["slug"]
    response = requests.get(BASE_URL.format(slug=slug), headers=HEADERS, timeout=30)
    response.raise_for_status()
    data = response.json()

    jobs = []
    for job in data.get("jobs", []):
        if not job.get("isListed", True):
            continue
        jobs.append({
            "external_job_id": job["id"],
            "job_title": job["title"],
            "department": job.get("department"),
            "location": job.get("location"),
            "apply_url": job.get("jobUrl", ""),
            "posted_date": job.get("publishedAt", "")[:10] if job.get("publishedAt") else None,
            "raw": job,
        })

    return jobs
