"""
Deep ATS Detection using Playwright — for companies that returned unknown/error in detect_ats.py
Renders the page fully (JS executed), then checks URLs + HTML + network requests for ATS fingerprints.

Run: python3 detect_ats_deep.py
Output: ats_detection_results.csv (merged/updated)
"""

import csv
import re
import time
from playwright.sync_api import sync_playwright

ATS_FINGERPRINTS = [
    (r"greenhouse\.io",                   "greenhouse"),
    (r"boards\.greenhouse\.io",           "greenhouse"),
    (r"grnh\.se",                         "greenhouse"),
    (r"lever\.co",                        "lever"),
    (r"jobs\.lever\.co",                  "lever"),
    (r"ashbyhq\.com",                     "ashby"),
    (r"myworkdayjobs\.com",               "workday"),
    (r"workday\.com",                     "workday"),
    (r"icims\.com",                       "icims"),
    (r"smartrecruiters\.com",             "smartrecruiters"),
    (r"successfactors\.(eu|com)",         "successfactors"),
    (r"taleo\.net",                       "taleo"),
    (r"bamboohr\.com",                    "bamboohr"),
    (r"rippling\.com/jobs",               "rippling"),
    (r"jobvite\.com",                     "jobvite"),
    (r"workable\.com",                    "workable"),
    (r"recruitee\.com",                   "recruitee"),
    (r"personio\.(com|de)",               "personio"),
    (r"careers\.oracle\.com",             "oracle_jobs"),
    (r"oraclecloud\.com",                 "oracle_hcm"),
    (r"phenom\.com",                      "phenom"),
    (r"eightfold\.ai",                    "eightfold"),
    (r"pinpointhq\.com",                  "pinpoint"),
    (r"doverhq\.com",                     "dover"),
    (r"jobs\.uber\.com",                  "uber"),
    (r"paylocity\.com",                   "paylocity"),
    (r"paycor\.com",                      "paycor"),
    (r"ultipro\.com",                     "ultipro"),
    (r"hiring\.amazon\.com",              "amazon"),
    (r"jobs\.apple\.com",                 "apple"),
    (r"careers\.google\.com",             "google"),
    (r"metacareers\.com",                 "meta"),
    (r"careers\.microsoft\.com",          "microsoft"),
    (r"snap\.com/en-US/jobs",             "snap_custom"),
    (r"jazzhr\.com",                      "jazzhr"),
    (r"breezyhr\.com",                    "breezyhr"),
    (r"applytojob\.com",                  "jazzhr"),
    (r"hire\.trakstar\.com",              "trakstar"),
    (r"fountainhq\.com",                  "fountain"),
    (r"comeet\.com",                      "comeet"),
    (r"teamtailor\.com",                  "teamtailor"),
    (r"join\.com",                        "join"),
    (r"careers-page\.com",               "careers_page"),
]


def detect_from_text(text: str) -> str:
    for pattern, ats in ATS_FINGERPRINTS:
        if re.search(pattern, text, re.IGNORECASE):
            return ats
    return None


def check_company_deep(page, company: str, url: str) -> dict:
    result = {"company": company, "careers_url": url, "detected_ats": "unknown",
              "evidence": None, "final_url": None, "error": None}
    captured_urls = []

    def on_request(req):
        captured_urls.append(req.url)

    page.on("request", on_request)

    try:
        page.goto(url, wait_until="networkidle", timeout=25000)
        time.sleep(1)

        final_url = page.url
        result["final_url"] = final_url

        # 1. Final URL after JS redirects
        ats = detect_from_text(final_url)
        if ats:
            result["detected_ats"] = ats
            result["evidence"] = f"Final URL: {final_url}"
            return result

        # 2. All network requests made by the page
        for req_url in captured_urls:
            ats = detect_from_text(req_url)
            if ats:
                result["detected_ats"] = ats
                result["evidence"] = f"Network request: {req_url[:120]}"
                return result

        # 3. Rendered HTML
        html = page.content()
        ats = detect_from_text(html)
        if ats:
            result["detected_ats"] = ats
            result["evidence"] = "Found in rendered HTML"
            return result

        # 4. All href links in rendered page
        links = page.eval_on_selector_all("a[href]", "els => els.map(e => e.href)")
        for link in links:
            ats = detect_from_text(link)
            if ats:
                result["detected_ats"] = ats
                result["evidence"] = f"Link href: {link[:120]}"
                return result

    except Exception as e:
        result["detected_ats"] = "error"
        result["error"] = str(e)[:100]
    finally:
        page.remove_listener("request", on_request)

    return result


def main():
    # Load previous results — only re-check unknown/error
    prev_results = {}
    with open("ats_detection_results.csv") as f:
        for row in csv.DictReader(f):
            prev_results[row["company"]] = row

    to_check = [
        (r["company"], r["careers_url"])
        for r in prev_results.values()
        if r["detected_ats"] in ("unknown", "error")
    ]

    print(f"Deep-checking {len(to_check)} companies with Playwright...\n")

    updated = {}
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            user_agent=(
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
            ),
            viewport={"width": 1280, "height": 800},
        )

        for i, (name, url) in enumerate(to_check, 1):
            page = context.new_page()
            r = check_company_deep(page, name, url)
            page.close()
            updated[name] = r
            print(f"[{i}/{len(to_check)}] {name:35s} → {r['detected_ats']}")

        browser.close()

    # Merge results
    final = []
    for company, row in prev_results.items():
        if company in updated:
            final.append(updated[company])
        else:
            final.append(row)

    final.sort(key=lambda x: (x["detected_ats"] or "zzz", x["company"]))

    with open("ats_detection_results.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["company", "careers_url", "detected_ats", "evidence", "final_url", "error"])
        writer.writeheader()
        writer.writerows(final)

    from collections import Counter
    counts = Counter(r["detected_ats"] for r in final)
    print("\n=== FINAL ATS BREAKDOWN ===")
    for ats, count in counts.most_common():
        print(f"  {ats:30s} {count:3d} companies")
    print(f"\nUpdated results saved to ats_detection_results.csv")


if __name__ == "__main__":
    main()
