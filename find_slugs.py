"""
Playwright slug finder for JS-rendered career pages.
Intercepts network requests to identify Greenhouse/Lever/Ashby slugs.

Run: python3 find_slugs.py
Output: slug_results.csv
"""

import csv
import re
import time
from playwright.sync_api import sync_playwright

TARGETS = [
    # (company_name, careers_url)
    ("Kajabi",       "https://www.kajabi.com/careers"),
    ("Noom",         "https://www.noom.com/careers/job-listings/"),
    ("Teachable",    "https://www.teachable.com/careers"),
    ("Numerade",     "https://www.numerade.com/careers/"),
    ("Airfocus",     "https://airfocus.com/careers/"),
    ("Codecademy",   "https://www.codecademy.com/about/careers"),
    ("Gladly",       "https://www.gladly.ai/careers/"),
    ("MX",           "https://www.mx.com/careers/"),
    ("Stord",        "https://www.stord.com/careers"),
    ("SentinelOne",  "https://www.sentinelone.com/jobs/"),
    ("Payhawk",      "https://payhawk.com/careers"),
    ("Pipe",         "https://pipe.com/careers"),
    ("Scalapay",     "https://www.scalapay.com/careers"),
    ("Wonderlic",    "https://wonderlic.com/jobs/"),
    ("Glean",        "https://www.glean.com/careers"),
    ("EasyPost",     "https://www.easypost.com/careers"),
    ("Hinge",        "https://hinge.co/careers"),
    ("Reflektive",   "https://www.reflektive.com/company/careers/"),
    ("DolarApp",     "https://www.dolarapp.com/careers"),
    ("Criteo",       "https://careers.criteo.com/en/"),
    ("Tempus",       "https://www.tempus.com/careers/"),
    ("Buildertrend", "https://buildertrend.com/careers/"),
    ("Empower",      "https://www.empower.me/careers"),
    ("Wonder",       "https://www.wonder.com/careers"),
]

ATS_PATTERNS = [
    (r"boards(?:-api)?\.greenhouse\.io/(?:v1/boards/)?([a-z0-9_-]+)", "greenhouse"),
    (r"job-boards\.greenhouse\.io/([a-z0-9_-]+)",                      "greenhouse"),
    (r"api\.greenhouse\.io/v1/boards/([a-z0-9_-]+)",                   "greenhouse"),
    (r"jobs\.lever\.co/([a-z0-9_-]+)",                                  "lever"),
    (r"api\.lever\.co/v0/postings/([a-z0-9_-]+)",                       "lever"),
    (r"jobs\.ashbyhq\.com/([a-z0-9_-]+)",                               "ashby"),
    (r"api\.ashbyhq\.com/posting-api/job-board/([a-z0-9_-]+)",          "ashby"),
    (r"([a-z0-9]+)\.wd(\d+)\.myworkdayjobs\.com",                       "workday"),
]


def find_slug(page, company: str, url: str) -> dict:
    result = {"company": company, "url": url, "ats": None, "slug": None, "evidence": None, "error": None}
    captured = []

    def on_request(req):
        captured.append(req.url)

    page.on("request", on_request)

    try:
        page.goto(url, wait_until="domcontentloaded", timeout=25000)
        time.sleep(4)

        all_text = " ".join(captured) + " " + page.url + " " + page.content()

        for pattern, ats in ATS_PATTERNS:
            m = re.search(pattern, all_text, re.IGNORECASE)
            if m:
                slug = m.group(1)
                if slug in ("embed", "js", "css", "v1", "v2", "api", "jobs"):
                    continue
                result["ats"] = ats
                result["slug"] = slug
                result["evidence"] = m.group(0)[:100]
                return result

        result["ats"] = "unknown"
    except Exception as e:
        result["ats"] = "error"
        result["error"] = str(e)[:100]
    finally:
        page.remove_listener("request", on_request)

    return result


def main():
    print(f"Finding slugs for {len(TARGETS)} companies...\n")
    results = []

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            user_agent=(
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
            ),
            viewport={"width": 1280, "height": 800},
        )

        for i, (name, url) in enumerate(TARGETS, 1):
            page = context.new_page()
            r = find_slug(page, name, url)
            page.close()
            results.append(r)
            slug_info = f"{r['ats']}:{r['slug']}" if r['slug'] else r['ats']
            print(f"[{i}/{len(TARGETS)}] {name:20s} → {slug_info}")

        browser.close()

    with open("slug_results.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["company", "url", "ats", "slug", "evidence", "error"])
        writer.writeheader()
        writer.writerows(results)

    print("\n=== RESULTS ===")
    found = [r for r in results if r["slug"]]
    unknown = [r for r in results if r["ats"] in ("unknown", "error")]
    print(f"Found: {len(found)} | Still unknown: {len(unknown)}")
    print("\nFound slugs:")
    for r in found:
        print(f"  {r['company']:20s} {r['ats']:12s} {r['slug']}")
    if unknown:
        print("\nStill unknown:")
        for r in unknown:
            print(f"  {r['company']:20s} {r['ats']} {r.get('error','')}")

    print("\nResults saved to slug_results.csv")


if __name__ == "__main__":
    main()
