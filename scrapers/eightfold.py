"""
Eightfold AI scraper.
Eightfold protects its /api/pcsx/search endpoint with session CSRF, so we
use Playwright to open the careers page (which sets the session), then call
the API from the page's own JS context — bypassing the auth check.

ats_config fields:
  domain       - company domain used in API param, e.g. "paypal.com"
  careers_url  - full URL to careers search page, e.g. "https://paypal.eightfold.ai/careers/job-search-results"
  search_text  - optional, defaults to "product manager"
"""

import time
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from scrapers.playwright_base import get_context

PAGE_SIZE = 25


def fetch(company: dict) -> list[dict]:
    cfg = company["ats_config"]
    domain = cfg["domain"]
    careers_url = cfg["careers_url"]
    search_text = cfg.get("search_text", "product manager")

    ctx = get_context()
    page = ctx.new_page()
    try:
        page.goto(careers_url, wait_until="domcontentloaded", timeout=30000)
        time.sleep(3)

        jobs = []
        start = 0

        while True:
            result = page.evaluate(f'''async () => {{
                const url = "/api/pcsx/search?domain={domain}&query={search_text}&location=United+States&start={start}&num={PAGE_SIZE}";
                const r = await fetch(url, {{headers: {{Accept: "application/json"}}}});
                return await r.json();
            }}''')

            data = result.get("data", {})
            positions = data.get("positions", [])
            total = data.get("count", 0)

            if not positions:
                break

            for j in positions:
                locs = j.get("standardizedLocations") or j.get("locations") or []
                us_locs = [l for l in locs if ", US" in l or "United States" in l]
                if not us_locs:
                    continue

                location_str = us_locs[0] if us_locs else (locs[0] if locs else "US")

                posted_ts = j.get("postedTs")
                posted_date = None
                if posted_ts:
                    from datetime import datetime, timezone
                    posted_date = datetime.fromtimestamp(posted_ts, tz=timezone.utc).strftime("%Y-%m-%d")

                job_id = str(j["id"])
                position_path = j.get("positionUrl", f"/careers/job/{job_id}")
                base = careers_url.split("/careers")[0]
                apply_url = f"{base}{position_path}"

                jobs.append({
                    "external_job_id": job_id,
                    "job_title": j["name"],
                    "department": j.get("department"),
                    "location": location_str,
                    "apply_url": apply_url,
                    "posted_date": posted_date,
                    "raw": j,
                })

            start += PAGE_SIZE
            if start >= total:
                break

        return jobs
    finally:
        page.close()
