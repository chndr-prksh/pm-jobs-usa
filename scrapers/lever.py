import requests

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
        categories = job.get("categories", {})
        jobs.append({
            "external_job_id": job["id"],
            "job_title": job["text"],
            "department": categories.get("department"),
            "location": categories.get("location"),
            "apply_url": job.get("hostedUrl", ""),
            "posted_date": None,
            "raw": job,
        })

    return jobs
