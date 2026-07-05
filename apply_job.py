"""
Real apply-agent run: fills out one specific job application (fills only —
never submits, per the review-before-submit rule in the agent's system
prompt). Downloads the base resume from Supabase Storage, mounts it into
the session, and points the agent at one job by ID.

Run: python3 apply_job.py <job_id>
"""

import os
import sys
import requests

from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()


def download_base_resume(local_path: str):
    supabase_url = os.environ["SUPABASE_URL"].rstrip("/")
    service_key = os.environ["SUPABASE_SERVICE_KEY"]

    resp = requests.get(
        f"{supabase_url}/rest/v1/resumes?is_base=eq.true&select=file_url,file_name",
        headers={"apikey": service_key, "Authorization": f"Bearer {service_key}"},
        timeout=15,
    )
    resp.raise_for_status()
    rows = resp.json()
    if not rows:
        raise RuntimeError("No base resume found in 'resumes' table — run ingest_resume.py first")
    file_url = rows[0]["file_url"]

    file_resp = requests.get(
        f"{supabase_url}/storage/v1/object/resumes/{file_url}",
        headers={"apikey": service_key, "Authorization": f"Bearer {service_key}"},
        timeout=30,
    )
    file_resp.raise_for_status()
    with open(local_path, "wb") as f:
        f.write(file_resp.content)
    return local_path


def get_job(job_id: str) -> dict:
    supabase_url = os.environ["SUPABASE_URL"].rstrip("/")
    service_key = os.environ["SUPABASE_SERVICE_KEY"]
    resp = requests.get(
        f"{supabase_url}/rest/v1/jobs?id=eq.{job_id}&select=id,job_title,apply_url,company_id",
        headers={"apikey": service_key, "Authorization": f"Bearer {service_key}"},
        timeout=15,
    )
    resp.raise_for_status()
    rows = resp.json()
    if not rows:
        raise RuntimeError(f"No job found with id {job_id}")
    job = rows[0]

    company_resp = requests.get(
        f"{supabase_url}/rest/v1/companies?id=eq.{job['company_id']}&select=company_name,ats",
        headers={"apikey": service_key, "Authorization": f"Bearer {service_key}"},
        timeout=15,
    )
    company_resp.raise_for_status()
    company = company_resp.json()[0]
    job["company_name"] = company["company_name"]
    job["ats"] = company["ats"]
    return job


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 apply_job.py <job_id>")
        sys.exit(1)

    job_id = sys.argv[1]
    job = get_job(job_id)
    print(f"Target: {job['company_name']} — {job['job_title']} ({job['ats']})")
    print(f"Apply URL: {job['apply_url']}")

    resume_path = "/tmp/base_resume.pdf"
    download_base_resume(resume_path)
    print(f"Downloaded base resume to {resume_path}")

    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])

    uploaded = client.beta.files.upload(file=open(resume_path, "rb"))
    print(f"Uploaded resume to Files API: {uploaded.id}")

    session = client.beta.sessions.create(
        agent={"type": "agent", "id": os.environ["ANTHROPIC_AGENT_ID"]},
        environment_id=os.environ["ANTHROPIC_ENVIRONMENT_ID"],
        vault_ids=[os.environ["ANTHROPIC_VAULT_ID"]],
        title=f"Apply: {job['company_name']} - {job['job_title']}",
        resources=[{
            "type": "file",
            "file_id": uploaded.id,
            "mount_path": "/workspace/resume.pdf",
        }],
    )
    print(f"Session ID: {session.id}")
    print(f"Console URL: https://platform.claude.com/workspaces/default/sessions/{session.id}")

    stream = client.beta.sessions.events.stream(session_id=session.id)
    client.beta.sessions.events.send(
        session_id=session.id,
        events=[{
            "type": "user.message",
            "content": [{
                "type": "text",
                "text": (
                    f"Your Telegram bot token for this session is: {os.environ['TELEGRAM_BOT_TOKEN']}\n\n"
                    f"Apply to this ONE job (do not pull others from job_matches this run):\n"
                    f"  job_id: {job['id']}\n"
                    f"  company: {job['company_name']}\n"
                    f"  ats: {job['ats']}\n"
                    f"  apply_url: {job['apply_url']}\n\n"
                    f"Your resume PDF is mounted at /workspace/resume.pdf. Fetch candidate_profile "
                    f"and question_bank from Supabase yourself per your instructions. Follow the "
                    f"per-ATS notes for {job['ats']}. Remember: fill only, never click Submit — stop "
                    f"at 'pending_review' and send me a Telegram summary of what you filled in."
                ),
            }],
        }],
    )

    for event in stream:
        if event.type == "agent.message":
            for block in event.content:
                if block.type == "text":
                    print(block.text, end="", flush=True)
        elif event.type == "agent.tool_use":
            print(f"\n[tool: {event.name}]", flush=True)
        elif event.type == "session.status_idle":
            if event.stop_reason.type != "requires_action":
                break
        elif event.type == "session.status_terminated":
            break
        elif event.type == "session.error":
            print(f"\n[ERROR] {event}")
            break

    print("\n\nDone. Check Telegram and Supabase 'applications' table for the result.")


if __name__ == "__main__":
    main()
