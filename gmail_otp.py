"""
Read-only IMAP helper: fetches an ATS's email-verification OTP code from
the applicant's own inbox. This is NOT captcha-solving — it's the real
applicant (via their own authorized tool, with their own app password)
proving they control their own email, which is the entire point of the
check. Never used for anything except reading recent verification emails.
"""

from __future__ import annotations

import email
import imaplib
import os
import re
import time

from dotenv import load_dotenv

load_dotenv()

IMAP_HOST = "imap.gmail.com"
CODE_RE = re.compile(r"\b[A-Za-z0-9]{6,8}\b")


def _extract_code(subject: str, body: str) -> str | None:
    text = f"{subject}\n{body}"
    # Prefer a code near explicit "code" language, to avoid grabbing
    # unrelated alphanumeric tokens (tracking IDs, etc.)
    for line in text.splitlines():
        if "code" in line.lower():
            match = CODE_RE.search(line)
            if match:
                return match.group(0)
    match = CODE_RE.search(text)
    return match.group(0) if match else None


def fetch_otp_code(sender_hint: str = "greenhouse", timeout_seconds: int = 90, poll_interval: int = 5) -> str | None:
    """Poll the inbox for a recent verification email matching sender_hint
    and return the extracted code, or None if nothing arrives in time."""
    address = os.environ["GMAIL_ADDRESS"]
    app_password = os.environ["GMAIL_APP_PASSWORD"].replace(" ", "")

    deadline = time.time() + timeout_seconds
    while time.time() < deadline:
        conn = imaplib.IMAP4_SSL(IMAP_HOST)
        try:
            conn.login(address, app_password)
            conn.select("INBOX", readonly=True)
            status, data = conn.search(None, "UNSEEN")
            ids = data[0].split() if status == "OK" else []
            for msg_id in reversed(ids[-10:]):
                status, msg_data = conn.fetch(msg_id, "(RFC822)")
                if status != "OK" or not msg_data or not msg_data[0]:
                    continue
                msg = email.message_from_bytes(msg_data[0][1])
                subject = msg.get("Subject", "") or ""
                from_addr = (msg.get("From", "") or "").lower()
                if sender_hint.lower() not in from_addr and sender_hint.lower() not in subject.lower():
                    continue

                body = ""
                if msg.is_multipart():
                    for part in msg.walk():
                        if part.get_content_type() == "text/plain":
                            body = part.get_payload(decode=True).decode(errors="ignore")
                            break
                else:
                    body = msg.get_payload(decode=True).decode(errors="ignore")

                code = _extract_code(subject, body)
                if code:
                    return code
        finally:
            conn.logout()
        time.sleep(poll_interval)
    return None
