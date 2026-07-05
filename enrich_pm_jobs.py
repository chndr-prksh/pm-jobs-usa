"""
Post-scrape enrichment for PM jobs only.

The main scraper (main.py) fetches every job at each company and computes
is_pm_role client-side, but does NOT fetch full job description text — that
would mean an extra request per job across ~600 companies, most of which
aren't PM roles at all.

This script runs after main.py and enriches ONLY jobs where is_pm_role = true
and description IS NULL:
  - Greenhouse / Lever / Ashby: description text is already sitting in
    raw_api_response from the original scrape — zero extra HTTP requests.
  - Workday: description isn't in the list-endpoint response at all, so this
    makes one detail-endpoint request per PM job (bounded to new PM postings
    only, not the full per-company job list).
  - Any other ATS: left alone for now (no detail-fetch built yet).

Also backfills city/country/is_us_job/canonical_apply_url for every job
missing them — pure string parsing, no network calls.

Run: python3 enrich_pm_jobs.py
"""

from __future__ import annotations

import os
import re
import requests
import psycopg2
import psycopg2.extras
from dotenv import load_dotenv

load_dotenv()

HEADERS = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"}

TRACKING_PARAMS = re.compile(
    r"[?&](utm_[a-z]+|gh_(src|jid)|src|token|source)=[^&]*", re.I
)


def get_conn():
    return psycopg2.connect(os.environ["SUPABASE_DB_URL"])


def canonicalize_url(url: str) -> str:
    if not url:
        return url
    cleaned = TRACKING_PARAMS.sub("", url)
    cleaned = re.sub(r"[?&]$", "", cleaned)
    cleaned = re.sub(r"\?&", "?", cleaned)
    return cleaned


def parse_city_country(location: str) -> tuple[str | None, str | None]:
    if not location:
        return None, None
    parts = [p.strip() for p in location.split(",")]
    if len(parts) >= 2:
        return parts[0], "US"  # scrapers already filter to US-only locations
    return None, "US"


def description_from_raw(ats: str, raw: dict) -> str | None:
    if ats == "greenhouse":
        return raw.get("content")
    if ats == "lever":
        return raw.get("description") or raw.get("descriptionPlain")
    if ats == "ashby":
        return raw.get("descriptionHtml") or raw.get("descriptionPlain")
    return None


def fetch_workday_detail(company: dict, job: dict) -> dict | None:
    cfg = company["ats_config"] or {}
    tenant, instance, site = cfg.get("tenant"), cfg.get("instance"), cfg.get("site")
    if not (tenant and instance and site):
        return None
    base = f"https://{tenant}.{instance}.myworkdayjobs.com/{site}"
    apply_url = job["apply_url"]
    if not apply_url.startswith(base):
        return None
    external_path = apply_url[len(base):]
    detail_url = f"https://{tenant}.{instance}.myworkdayjobs.com/wday/cxs/{tenant}/{site}{external_path}"
    try:
        r = requests.get(detail_url, headers=HEADERS, timeout=15)
        r.raise_for_status()
        return r.json().get("jobPostingInfo", {})
    except requests.RequestException:
        return None


def structured_fields_from_raw(ats: str, raw: dict, detail: dict | None = None) -> dict:
    """Extract employment_type/remote from each ATS's own structured metadata
    (no LLM, no JD parsing) where the field reliably exists."""
    fields: dict = {}

    if ats == "ashby":
        if raw.get("employmentType"):
            fields["employment_type"] = raw["employmentType"]
        workplace = (raw.get("workplaceType") or "").lower()
        if raw.get("isRemote") is True or "remote" in workplace:
            fields["remote"] = True
        elif workplace:
            fields["remote"] = False

    elif ats == "lever":
        commitment = raw.get("categories", {}).get("commitment")
        if commitment:
            fields["employment_type"] = commitment
        workplace = (raw.get("workplaceType") or "").lower()
        if workplace:
            fields["remote"] = "remote" in workplace

    elif ats == "greenhouse":
        # Custom per-company metadata field, name varies (e.g. "Workplace Type").
        # Best-effort only — many companies don't configure this field at all.
        for m in raw.get("metadata") or []:
            name = (m.get("name") or "").lower()
            if "workplace" in name or "remote" in name:
                val = str(m.get("value") or "").lower()
                fields["remote"] = "remote" in val
                break

    elif ats == "workday" and detail:
        if detail.get("timeType"):
            fields["employment_type"] = detail["timeType"]

    return fields


def backfill_location_fields(conn):
    """Cheap, no-network fixes for every job missing them."""
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute("""
            SELECT id, location, apply_url FROM jobs
            WHERE city IS NULL OR country IS NULL OR is_us_job IS NULL
               OR canonical_apply_url IS NULL
        """)
        rows = cur.fetchall()

    if not rows:
        return 0

    with conn.cursor() as cur:
        for row in rows:
            city, country = parse_city_country(row["location"])
            canonical = canonicalize_url(row["apply_url"])
            cur.execute("""
                UPDATE jobs SET city = %s, country = %s, is_us_job = true,
                       canonical_apply_url = %s, updated_at = now()
                WHERE id = %s
            """, (city, country, canonical, row["id"]))
    conn.commit()
    return len(rows)


def enrich_descriptions(conn):
    test_mode = os.environ.get("TEST_MODE", "").lower() == "true"
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute(f"""
            SELECT j.id, j.apply_url, j.raw_api_response,
                   c.ats, c.ats_config
            FROM jobs j
            JOIN companies c ON c.id = j.company_id
            WHERE j.is_pm_role = true
              AND j.is_active = true
              AND j.description IS NULL
              {"AND j.is_test_job = true" if test_mode else ""}
        """)
        rows = cur.fetchall()

    print(f"Enriching {len(rows)} PM jobs missing description...")

    filled, skipped, failed = 0, 0, 0
    with conn.cursor() as cur:
        for row in rows:
            try:
                ats = row["ats"]
                raw = row["raw_api_response"] or {}
                desc = description_from_raw(ats, raw)
                detail = None

                if ats == "workday":
                    company = {"ats_config": row["ats_config"]}
                    job = {"apply_url": row["apply_url"]}
                    detail = fetch_workday_detail(company, job)
                    if detail:
                        desc = detail.get("jobDescription")

                fields = structured_fields_from_raw(ats, raw, detail)

                if desc:
                    set_clauses = ["description = %s"]
                    params = [desc]
                    for col in ("employment_type", "remote"):
                        if col in fields:
                            set_clauses.append(f"{col} = %s")
                            params.append(fields[col])
                    params.append(row["id"])
                    cur.execute(
                        f"UPDATE jobs SET {', '.join(set_clauses)}, updated_at = now() WHERE id = %s",
                        params,
                    )
                    filled += 1
                elif ats in ("greenhouse", "lever", "ashby", "workday"):
                    failed += 1
                else:
                    skipped += 1
            except Exception as e:
                print(f"  [job {row['id']}] enrichment error: {e}")
                failed += 1

    conn.commit()
    print(f"Filled: {filled} | Failed (fetch/parse error): {failed} | Skipped (ATS not supported yet): {skipped}")


def main():
    conn = get_conn()
    n = backfill_location_fields(conn)
    print(f"Backfilled city/country/is_us_job/canonical_apply_url for {n} jobs")
    enrich_descriptions(conn)
    conn.close()


if __name__ == "__main__":
    main()
