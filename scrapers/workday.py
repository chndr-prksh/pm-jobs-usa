import requests

HEADERS = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-Agent": "Mozilla/5.0",
}

def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    tenant = cfg["tenant"]
    site = cfg["site"]
    server = cfg["server"]
    location_id = cfg.get("location_id")
    search_text = cfg.get("search_text", "product manager")

    url = f"https://{tenant}.{server}.myworkdayjobs.com/wday/cxs/{tenant}/{site}/jobs"

    location_facet = cfg.get("location_facet", "locationCountry")
    applied_facets = {}
    if location_id:
        applied_facets[location_facet] = [location_id]

    jobs = []
    offset = 0
    limit = 20

    while True:
        payload = {
            "appliedFacets": applied_facets,
            "limit": limit,
            "offset": offset,
            "searchText": search_text,
        }
        response = requests.post(url, json=payload, headers=HEADERS, timeout=30)
        response.raise_for_status()
        data = response.json()

        postings = data.get("jobPostings", [])
        if not postings:
            break

        for job in postings:
            external_path = job.get("externalPath", "")
            job_id = job.get("bulletFields", [""])[0]
            apply_url = f"https://{tenant}.{server}.myworkdayjobs.com/{site}{external_path}"
            jobs.append({
                "external_job_id": job_id or external_path,
                "job_title": job["title"],
                "department": None,
                "location": "Multiple Locations" if "Location" in job.get("locationsText", "") else job.get("locationsText"),
                "locations": [] if "Location" in job.get("locationsText", "") else ([job.get("locationsText")] if job.get("locationsText") else []),
                "apply_url": apply_url,
                "posted_date": None,
                "raw": job,
            })

        if offset + limit >= data.get("total", 0):
            break
        offset += limit

    return jobs
