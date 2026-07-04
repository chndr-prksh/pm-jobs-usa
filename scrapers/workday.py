from __future__ import annotations

import re
import requests

HEADERS = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-Agent": "Mozilla/5.0",
}

# Tried in order when the configured instance is missing or wrong.
INSTANCE_CANDIDATES = ["wd1", "wd5", "wd3", "wd12", "wd2", "wd10", "wd103", "wd108", "wd501", "wd503"]

def _sites_from_robots(tenant: str, instance: str) -> list[str]:
    """robots.txt lists every career site on the tenant, either as
    'Sitemap: https://{tenant}.{inst}.myworkdayjobs.com/{site}/siteMap.xml' or as
    'Disallow: /{site}/' entries. Returns [] if the tenant/instance is wrong
    (non-200, DNS failure, or ERR_TENANT_MIGRATED)."""
    url = f"https://{tenant}.{instance}.myworkdayjobs.com/robots.txt"
    r = requests.get(url, headers={"User-Agent": HEADERS["User-Agent"]}, timeout=12)
    if r.status_code != 200:
        return []
    sites = re.findall(r"myworkdayjobs\.com/([^/\s]+)/siteMap\.xml", r.text)
    sites += re.findall(r"Disallow:\s*/([^/\s]+)/", r.text)
    # Prefer external/career-sounding boards over internal or university ones
    return sorted(set(sites), key=lambda s: (0 if re.search(r"external|career", s, re.I) else 1, s))


def _jobs_endpoint_works(tenant: str, instance: str, site: str) -> bool:
    url = f"https://{tenant}.{instance}.myworkdayjobs.com/wday/cxs/{tenant}/{site}/jobs"
    try:
        r = requests.post(url, json={"appliedFacets": {}, "limit": 1, "offset": 0, "searchText": ""},
                          headers=HEADERS, timeout=12)
        return r.status_code == 200 and "jobPostings" in r.text
    except requests.RequestException:
        return False


def _resolve(tenant: str, instance: str | None, site: str | None) -> tuple[str, str]:
    """Find a working (instance, site) pair, probing candidates as needed."""
    instances = [instance] + [i for i in INSTANCE_CANDIDATES if i != instance] if instance else INSTANCE_CANDIDATES

    for inst in instances:
        # If a site is configured, trust it first
        if site and _jobs_endpoint_works(tenant, inst, site):
            return inst, site

        try:
            candidates = _sites_from_robots(tenant, inst)
        except requests.RequestException:
            continue
        for s in candidates:
            if _jobs_endpoint_works(tenant, inst, s):
                return inst, s

    raise ValueError(f"Could not resolve Workday instance/site for tenant '{tenant}'")


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    tenant = cfg["tenant"]
    # "instance" is the current key; "server" kept for back-compat with older rows
    instance = cfg.get("instance") or cfg.get("server")
    site = cfg.get("site")
    location_id = cfg.get("location_id")
    search_text = cfg.get("search_text", "product manager")

    instance, site = _resolve(tenant, instance, site)

    url = f"https://{tenant}.{instance}.myworkdayjobs.com/wday/cxs/{tenant}/{site}/jobs"

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
            apply_url = f"https://{tenant}.{instance}.myworkdayjobs.com/{site}{external_path}"
            jobs.append({
                "external_job_id": job_id or external_path,
                "job_title": job.get("title", "Untitled"),
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
