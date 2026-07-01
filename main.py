import os
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()

from db import get_conn, get_active_companies, upsert_jobs, log_scrape
from scrapers import greenhouse, ashby, workday, lever, uber, icims, workable
from scrapers import playwright_base
from generate_readme import generate

SCRAPERS = {
    "greenhouse": greenhouse.fetch,
    "ashby": ashby.fetch,
    "workday": workday.fetch,
    "lever": lever.fetch,
    "uber": uber.fetch,
    "icims": icims.fetch,
    "workable": workable.fetch,
}

def run():
    conn = get_conn()
    companies = get_active_companies(conn)
    print(f"Found {len(companies)} active companies")

    for company in companies:
        ats = company["ats"]
        name = company["company_name"]
        scraper = SCRAPERS.get(ats)

        if not scraper:
            print(f"[{name}] No scraper for ATS: {ats} — skipping")
            continue

        print(f"[{name}] Scraping ({ats})...")
        started_at = datetime.utcnow()

        try:
            jobs = scraper(company)
            counts = upsert_jobs(conn, company["id"], jobs)
            log_scrape(conn, company["id"], started_at, status="success",
                       jobs_found=len(jobs), **counts)
            print(f"[{name}] Done — {len(jobs)} jobs found | new:{counts['new_jobs']} updated:{counts['updated_jobs']} closed:{counts['closed_jobs']}")
        except Exception as e:
            log_scrape(conn, company["id"], started_at, status="failed", error_message=str(e))
            print(f"[{name}] FAILED — {e}")

    # Clean up Playwright browser if it was used
    playwright_base.close()

    conn.close()

    print("\nGenerating README and CSV...")
    generate()
    print("Done.")

if __name__ == "__main__":
    run()
