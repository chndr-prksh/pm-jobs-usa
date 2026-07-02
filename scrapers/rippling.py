"""
Rippling ATS scraper.
Rippling uses Next.js SSG — the build ID is embedded in the page HTML and
changes on each deploy. We fetch it once per run, then hit the _next/data
endpoint which returns all jobs in the dehydrated React Query state.

ats_config fields:
  slug  - Rippling job board slug, e.g. "kajabi"
"""

import re
import requests

BASE_HEADERS = {"User-Agent": "Mozilla/5.0"}
PAGE_SIZE = 100


def _get_build_id(slug: str) -> str:
    r = requests.get(f"https://ats.rippling.com/{slug}/jobs", headers=BASE_HEADERS, timeout=15)
    r.raise_for_status()
    m = re.search(r'"buildId":"([^"]+)"', r.text)
    if not m:
        raise ValueError(f"Could not find Rippling buildId for slug '{slug}'")
    return m.group(1)


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    slug = cfg["slug"]
    search_text = cfg.get("search_text", "product manager")

    build_id = _get_build_id(slug)
    jobs = []
    page = 0

    while True:
        url = (
            f"https://ats.rippling.com/_next/data/{build_id}/en-US/{slug}/jobs.json"
            f"?jobBoardSlug={slug}"
        )
        params = {
            "searchQuery": search_text,
            "page": page,
            "pageSize": PAGE_SIZE,
        }
        # Rippling bakes first page into the SSG data; subsequent pages need query params
        if page == 0:
            r = requests.get(url, headers=BASE_HEADERS, timeout=15)
        else:
            r = requests.get(url, params=params, headers=BASE_HEADERS, timeout=15)
        r.raise_for_status()

        data = r.json()
        queries = data.get("pageProps", {}).get("dehydratedState", {}).get("queries", [])
        job_query = next(
            (q for q in queries if "job-posts" in str(q.get("queryKey", []))),
            None,
        )
        if not job_query:
            break

        state_data = job_query["state"]["data"]
        items = state_data.get("items", [])
        total = state_data.get("totalItems", 0)

        if not items:
            break

        for j in items:
            locs = j.get("locations", [])
            us_locs = [l for l in locs if l.get("countryCode", "").upper() == "US"]
            if not us_locs:
                continue

            loc = us_locs[0]
            location_str = ", ".join(filter(None, [loc.get("city"), loc.get("stateCode"), "US"]))

            dept = j.get("department", {})
            dept_str = dept.get("name") if dept else None

            job_id = j["id"]
            apply_url = j.get("url") or f"https://ats.rippling.com/{slug}/jobs/{job_id}"

            jobs.append({
                "external_job_id": job_id,
                "job_title": j["name"],
                "department": dept_str,
                "location": location_str,
                "apply_url": apply_url,
                "posted_date": None,
                "raw": j,
            })

        page += 1
        if page * PAGE_SIZE >= total:
            break

    return jobs
