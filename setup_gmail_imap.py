"""
One-time setup: stores your Gmail address and an APP PASSWORD (not your
regular Google password — see below) locally in .env, hidden from the
terminal transcript. Used read-only, to fetch ATS email-verification OTP
codes sent to your own inbox.

You need a Gmail "App Password", not your normal password:
  1. Turn on 2-Step Verification: https://myaccount.google.com/security
  2. Create an App Password: https://myaccount.google.com/apppasswords
  3. Paste that 16-character app password below (not your login password).

Run: python3 setup_gmail_imap.py
"""

import getpass
import os

ENV_PATH = os.path.join(os.path.dirname(__file__), ".env")


def upsert_env_var(key: str, value: str):
    lines = []
    if os.path.exists(ENV_PATH):
        with open(ENV_PATH) as f:
            lines = f.readlines()
    lines = [l for l in lines if not l.startswith(f"{key}=")]
    lines.append(f"{key}={value}\n")
    with open(ENV_PATH, "w") as f:
        f.writelines(lines)


def main():
    email = input("Gmail address: ").strip()
    app_password = getpass.getpass("Gmail App Password (hidden input, 16 chars, no spaces): ").strip()

    upsert_env_var("GMAIL_ADDRESS", email)
    upsert_env_var("GMAIL_APP_PASSWORD", app_password)
    print("Saved GMAIL_ADDRESS and GMAIL_APP_PASSWORD to .env (gitignored, read-only IMAP use).")


if __name__ == "__main__":
    main()
