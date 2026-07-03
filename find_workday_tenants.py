"""
Workday tenant extractor.
Visits each Workday career page, intercepts network requests,
and extracts the tenant + instance from the myworkdayjobs.com URL.

Run: python3 find_workday_tenants.py
Output: workday_tenants.csv
"""

import csv
import re
import time
from playwright.sync_api import sync_playwright

WD_PATTERN = re.compile(r'([a-z0-9_-]+)\.(wd\d+)\.myworkdayjobs\.com', re.I)

def load_targets():
    targets = []
    with open("new_companies_to_add.csv") as f:
        for r in csv.DictReader(f):
            if r["ats"] == "Workday":
                targets.append((r["company_name"].strip(), r["career_url"].strip()))
    return targets


def extract_tenant(page, name, url):
    captured = []
    page.on("request", lambda req: captured.append(req.url))
    page.on("response", lambda res: captured.append(res.url))

    try:
        page.goto(url, wait_until="domcontentloaded", timeout=25000)
        time.sleep(3)

        # Check all captured URLs + page source for myworkdayjobs pattern
        all_text = " ".join(captured) + " " + page.url + " " + page.content()
        m = WD_PATTERN.search(all_text)
        if m:
            return m.group(1).lower(), m.group(2).lower(), "page_load"

        # Try clicking first job-looking link
        links = page.eval_on_selector_all(
            "a[href]",
            "els => els.map(e => e.href).filter(h => h && (h.includes('job') || h.includes('career') || h.includes('apply') || h.includes('position') || h.includes('role')))"
        )
        for link in links[:8]:
            m = WD_PATTERN.search(link)
            if m:
                return m.group(1).lower(), m.group(2).lower(), f"link:{link[:60]}"

        # Open first job link in new tab
        job_page = page.context.new_page()
        job_page.on("request", lambda req: captured.append(req.url))
        job_page.on("response", lambda res: captured.append(res.url))
        for link in links[:5]:
            try:
                job_page.goto(link, wait_until="domcontentloaded", timeout=15000)
                time.sleep(2)
                all_text2 = " ".join(captured) + " " + job_page.url + " " + job_page.content()
                m = WD_PATTERN.search(all_text2)
                if m:
                    job_page.close()
                    return m.group(1).lower(), m.group(2).lower(), f"followed:{link[:60]}"
            except Exception:
                continue
        job_page.close()

    except Exception as e:
        return None, None, f"error:{str(e)[:80]}"

    return None, None, "not_found"


def main():
    targets = load_targets()
    print(f"Extracting Workday tenants for {len(targets)} companies...\n")

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
            tenant, instance, evidence = extract_tenant(page, name, url)
            page.close()

            results.append({
                "company_name": name,
                "career_url": url,
                "tenant": tenant or "",
                "instance": instance or "",
                "evidence": evidence,
            })

            status = f"{tenant}.{instance}" if tenant else "NOT_FOUND"
            print(f"[{i:3d}/{len(targets)}] {name:40s} → {status}")

        browser.close()

    with open("workday_tenants.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["company_name", "career_url", "tenant", "instance", "evidence"])
        w.writeheader()
        w.writerows(results)

    found = [r for r in results if r["tenant"]]
    print(f"\nFound: {len(found)} / {len(targets)}")
    print("Saved to workday_tenants.csv")


if __name__ == "__main__":
    main()
