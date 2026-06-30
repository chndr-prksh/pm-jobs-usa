import csv
import os
from datetime import datetime, timezone
from db import get_conn, get_active_jobs_for_readme, get_all_active_jobs_for_csv

def generate(readme_path="README.md", csv_path="jobs.csv"):
    conn = get_conn()
    readme_jobs = get_active_jobs_for_readme(conn, limit=100)
    all_jobs = get_all_active_jobs_for_csv(conn)
    conn.close()

    updated_at = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")

    lines = [
        "# PM Jobs USA 🇺🇸",
        "",
        f"> Auto-updated every 24h · Last refresh: {updated_at} · [Full list →](jobs.csv)",
        "",
        f"Showing top 100 most recently posted Product Management jobs across {len(set(j['company_name'] for j in readme_jobs))} companies.",
        "",
        "| Company | Role | Location | Posted | Apply |",
        "|---------|------|----------|--------|-------|",
    ]

    for job in readme_jobs:
        posted = str(job["posted_date"]) if job["posted_date"] else "—"
        location = job["location"] or "—"
        lines.append(
            f"| {job['company_name']} | {job['job_title']} | {location} | {posted} | [Apply]({job['apply_url']}) |"
        )

    lines += [
        "",
        "---",
        f"*{len(all_jobs)} total active PM jobs tracked. Download [jobs.csv](jobs.csv) for the full dataset.*",
        "",
        "**Want to contribute a company?** Open an issue with the company name and their careers page URL.",
    ]

    with open(readme_path, "w") as f:
        f.write("\n".join(lines))

    with open(csv_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=[
            "company_name", "ats", "job_title", "department",
            "location", "remote", "posted_date", "apply_url",
            "external_job_id", "first_seen"
        ])
        writer.writeheader()
        writer.writerows(all_jobs)

    print(f"README: {len(readme_jobs)} jobs | CSV: {len(all_jobs)} total jobs")

if __name__ == "__main__":
    generate()
