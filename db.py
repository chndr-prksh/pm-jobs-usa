import os
import psycopg2
import psycopg2.extras
from datetime import datetime

def get_conn():
    return psycopg2.connect(os.environ["SUPABASE_DB_URL"])

def get_active_companies(conn):
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute("SELECT * FROM companies WHERE active = true ORDER BY company_name")
        return cur.fetchall()

def upsert_jobs(conn, company_id, jobs: list[dict]) -> dict:
    new_jobs = 0
    updated_jobs = 0

    with conn.cursor() as cur:
        for job in jobs:
            cur.execute("""
                INSERT INTO jobs (
                    company_id, external_job_id, job_title, department,
                    location, apply_url, posted_date, is_active,
                    raw_api_response, last_seen
                ) VALUES (
                    %s, %s, %s, %s, %s, %s, %s, true, %s, now()
                )
                ON CONFLICT (company_id, external_job_id) DO UPDATE SET
                    job_title = EXCLUDED.job_title,
                    location = EXCLUDED.location,
                    apply_url = EXCLUDED.apply_url,
                    posted_date = EXCLUDED.posted_date,
                    is_active = true,
                    raw_api_response = EXCLUDED.raw_api_response,
                    last_seen = now(),
                    updated_at = now()
                RETURNING (xmax = 0) as inserted
            """, (
                company_id,
                job["external_job_id"],
                job["job_title"],
                job.get("department"),
                job.get("location"),
                job["apply_url"],
                job.get("posted_date"),
                psycopg2.extras.Json(job.get("raw")),
            ))
            row = cur.fetchone()
            if row and row[0]:
                new_jobs += 1
            else:
                updated_jobs += 1

        # Mark jobs no longer returned by API as inactive
        active_ids = [j["external_job_id"] for j in jobs]
        if active_ids:
            cur.execute("""
                UPDATE jobs SET is_active = false, updated_at = now()
                WHERE company_id = %s
                AND external_job_id != ALL(%s)
                AND is_active = true
            """, (company_id, active_ids))
            closed_jobs = cur.rowcount
        else:
            closed_jobs = 0

    conn.commit()
    return {"new_jobs": new_jobs, "updated_jobs": updated_jobs, "closed_jobs": closed_jobs}

def log_scrape(conn, company_id, started_at, status, jobs_found=0,
               new_jobs=0, updated_jobs=0, closed_jobs=0, error_message=None):
    finished_at = datetime.utcnow()
    execution_seconds = int((finished_at - started_at).total_seconds())
    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO scrape_logs
                (company_id, started_at, finished_at, jobs_found, new_jobs,
                 updated_jobs, closed_jobs, status, error_message, execution_time_seconds)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (company_id, started_at, finished_at, jobs_found,
              new_jobs, updated_jobs, closed_jobs, status, error_message, execution_seconds))

        if status == "success":
            cur.execute("""
                UPDATE companies SET
                    last_scraped_at = now(),
                    next_scrape_at = now() + interval '24 hours',
                    total_jobs_last_scrape = %s,
                    avg_scrape_duration_seconds = %s,
                    consecutive_failures = 0,
                    ats_error = false,
                    last_error_message = null,
                    updated_at = now()
                WHERE id = %s
            """, (jobs_found, execution_seconds, company_id))
        else:
            cur.execute("""
                UPDATE companies SET
                    consecutive_failures = consecutive_failures + 1,
                    ats_error = true,
                    last_error_message = %s,
                    updated_at = now()
                WHERE id = %s
            """, (error_message, company_id))

    conn.commit()

def get_active_jobs_for_readme(conn, limit=100):
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute("""
            SELECT j.job_title, c.company_name, j.location, j.posted_date, j.apply_url
            FROM jobs j
            JOIN companies c ON c.id = j.company_id
            WHERE j.is_active = true
            ORDER BY j.posted_date DESC NULLS LAST, j.first_seen DESC
            LIMIT %s
        """, (limit,))
        return cur.fetchall()

def get_all_active_jobs_for_csv(conn):
    with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
        cur.execute("""
            SELECT c.company_name, c.ats, j.job_title, j.department,
                   j.location, j.remote, j.posted_date, j.apply_url,
                   j.external_job_id, j.first_seen
            FROM jobs j
            JOIN companies c ON c.id = j.company_id
            WHERE j.is_active = true
            ORDER BY j.posted_date DESC NULLS LAST
        """)
        return cur.fetchall()
