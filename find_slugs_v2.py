"""
ATS slug finder v2 — "click the apply button" approach.

For each company:
1. Visit the careers page
2. Find the first clickable job link
3. Follow it (new tab or redirect)
4. Read the final URL to fingerprint the ATS + extract slug

Run: python3 find_slugs_v2.py
Output: slug_results_v2.csv
"""

import csv
import re
import time
from playwright.sync_api import sync_playwright

# Load companies from manual_lookup_updated.csv (corrected career URLs)
def load_targets(src="manual_lookup_updated.csv"):
    targets = []
    with open(src) as f:
        for row in csv.DictReader(f):
            targets.append((row["company_name"].strip(), row["career_url"].strip()))
    return targets


ATS_PATTERNS = [
    (r"([a-z0-9_-]+)\.wd\d+\.myworkdayjobs\.com",              "workday",         lambda m: m.group(0)),
    (r"boards(?:-api)?\.greenhouse\.io/(?:v1/boards/)?([a-z0-9_-]+)", "greenhouse", lambda m: m.group(1)),
    (r"job-boards\.greenhouse\.io/([a-z0-9_-]+)",               "greenhouse",      lambda m: m.group(1)),
    (r"greenhouse\.io/embed/job_board/js\?for=([a-z0-9_-]+)",  "greenhouse",      lambda m: m.group(1)),
    (r"jobs\.lever\.co/([a-z0-9_-]+)",                          "lever",           lambda m: m.group(1)),
    (r"api\.lever\.co/v0/postings/([a-z0-9_-]+)",               "lever",           lambda m: m.group(1)),
    (r"jobs\.ashbyhq\.com/([a-z0-9_-]+)",                       "ashby",           lambda m: m.group(1)),
    (r"api\.ashbyhq\.com/posting-api/job-board/([a-z0-9_-]+)", "ashby",           lambda m: m.group(1)),
    (r"ats\.rippling\.com/([a-z0-9_-]+)/jobs",                  "rippling",        lambda m: m.group(1)),
    (r"apply\.workable\.com/([a-z0-9_-]+)",                     "workable",        lambda m: m.group(1)),
    (r"smartrecruiters\.com/([A-Za-z0-9_-]+)/",                 "smartrecruiters", lambda m: m.group(1)),
    (r"([a-z0-9-]+)\.bamboohr\.com/careers",                    "bamboohr",        lambda m: m.group(1)),
    (r"([a-z0-9-]+)\.eightfold\.ai/careers",                    "eightfold",       lambda m: m.group(0)),
    (r"([a-z0-9-]+)\.pinpointhq\.com",                          "pinpoint",        lambda m: m.group(1)),
    (r"icims\.com",                                              "icims",           lambda m: "icims"),
    (r"successfactors\.(eu|com)",                                "successfactors",  lambda m: "successfactors"),
    (r"taleo\.net",                                              "taleo",           lambda m: "taleo"),
    (r"jobvite\.com",                                            "jobvite",         lambda m: "jobvite"),
    (r"paylocity\.com",                                          "paylocity",       lambda m: "paylocity"),
    (r"oracle.*cloud\.com",                                      "oracle_hcm",      lambda m: "oracle_hcm"),
    (r"careers\.oracle\.com",                                    "oracle_jobs",     lambda m: "oracle_jobs"),
    (r"hiring\.amazon\.com",                                     "amazon",          lambda m: "amazon"),
    (r"jobs\.apple\.com",                                        "apple",           lambda m: "apple"),
    (r"careers\.google\.com",                                    "google",          lambda m: "google"),
    (r"metacareers\.com",                                        "meta",            lambda m: "meta"),
    (r"careers\.microsoft\.com",                                 "microsoft",       lambda m: "microsoft"),
    (r"linkedin\.com/jobs",                                      "linkedin",        lambda m: "linkedin"),
    (r"breezyhr\.com",                                           "breezyhr",        lambda m: "breezyhr"),
    (r"recruitee\.com",                                          "recruitee",       lambda m: "recruitee"),
    (r"teamtailor\.com",                                         "teamtailor",      lambda m: "teamtailor"),
    (r"personio\.(com|de)",                                      "personio",        lambda m: "personio"),
    (r"jazzhr\.com|applytojob\.com",                             "jazzhr",          lambda m: "jazzhr"),
    (r"dover\.com/apply",                                        "dover",           lambda m: "dover"),
    (r"jobs\.lever\.co",                                         "lever",           lambda m: "lever"),
]

SKIP_SLUGS = {"embed", "js", "css", "v1", "v2", "api", "jobs", "en", "en-US", "careers", ""}

JOB_LINK_SELECTORS = [
    "a[href*='lever.co']",
    "a[href*='greenhouse.io']",
    "a[href*='ashbyhq.com']",
    "a[href*='workdayjobs.com']",
    "a[href*='rippling.com']",
    "a[href*='workable.com']",
    "a[href*='smartrecruiters.com']",
    "a[href*='bamboohr.com']",
    "a[href*='eightfold.ai']",
    "a[href*='pinpointhq.com']",
    "a[href*='icims.com']",
    "a[href*='successfactors']",
    "a[href*='taleo.net']",
    "a[href*='jobvite.com']",
    "a[href*='paylocity.com']",
    "a[href*='oracle']",
    "a[href*='apply']",
    "a[href*='job']",
    "[data-job-id] a",
    ".job-listing a",
    ".careers-list a",
    "li.job a",
]


def detect_ats(text: str):
    for pattern, ats, slug_fn in ATS_PATTERNS:
        m = re.search(pattern, text, re.IGNORECASE)
        if m:
            slug = slug_fn(m)
            if slug not in SKIP_SLUGS:
                return ats, slug
    return None, None


def check_company(page, name: str, url: str) -> dict:
    result = {"company": name, "careers_url": url, "ats": None, "slug": None, "evidence": None, "error": None}
    captured_urls = []

    page.on("request", lambda req: captured_urls.append(req.url))

    try:
        page.goto(url, wait_until="domcontentloaded", timeout=25000)
        time.sleep(3)

        # 1. Check final URL + all network requests so far
        all_text = " ".join(captured_urls) + " " + page.url + " " + page.content()
        ats, slug = detect_ats(all_text)
        if ats:
            result["ats"] = ats
            result["slug"] = slug
            result["evidence"] = f"page load: {page.url[:80]}"
            return result

        # 2. Find any job link and follow it
        for selector in JOB_LINK_SELECTORS:
            try:
                links = page.eval_on_selector_all(selector, "els => els.map(e => e.href).filter(Boolean)")
                for link in links[:5]:
                    if not link or link == url:
                        continue
                    ats, slug = detect_ats(link)
                    if ats:
                        result["ats"] = ats
                        result["slug"] = slug
                        result["evidence"] = f"job link: {link[:100]}"
                        return result
            except Exception:
                continue

        # 3. Click the first visible job-looking link and follow the redirect
        try:
            job_page = page.context.new_page()
            job_page.on("request", lambda req: captured_urls.append(req.url))

            # Find first link that looks like a job
            all_links = page.eval_on_selector_all(
                "a[href]", "els => els.map(e => e.href).filter(h => h && !h.endsWith('.css') && !h.endsWith('.js'))"
            )
            for link in all_links:
                if any(kw in link.lower() for kw in ["job", "career", "apply", "position", "role", "opening"]):
                    try:
                        job_page.goto(link, wait_until="domcontentloaded", timeout=15000)
                        time.sleep(2)
                        all_text2 = " ".join(captured_urls) + " " + job_page.url + " " + job_page.content()
                        ats, slug = detect_ats(all_text2)
                        if ats:
                            result["ats"] = ats
                            result["slug"] = slug
                            result["evidence"] = f"followed link {link[:60]} → {job_page.url[:80]}"
                            job_page.close()
                            return result
                    except Exception:
                        continue
            job_page.close()
        except Exception:
            pass

        result["ats"] = "unknown"

    except Exception as e:
        result["ats"] = "error"
        result["error"] = str(e)[:120]

    return result


def main():
    targets = load_targets()
    print(f"Checking {len(targets)} companies using apply-link approach...\n")

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

        for i, (name, url) in enumerate(targets, 1):
            page = context.new_page()
            r = check_company(page, name, url)
            page.close()
            results.append(r)
            info = f"{r['ats']}:{r['slug']}" if r["slug"] else r["ats"]
            print(f"[{i:3d}/{len(targets)}] {name:35s} → {info}")

        browser.close()

    with open("slug_results_v3.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["company", "careers_url", "ats", "slug", "evidence", "error"])
        writer.writeheader()
        writer.writerows(results)

    from collections import Counter
    counts = Counter(r["ats"] for r in results)
    print("\n=== BREAKDOWN ===")
    for ats, count in counts.most_common():
        print(f"  {ats:30s} {count:3d}")

    found = [r for r in results if r["slug"]]
    print(f"\nTotal resolved: {len(found)} / {len(targets)}")
    print("Results saved to slug_results_v3.csv")


if __name__ == "__main__":
    main()
