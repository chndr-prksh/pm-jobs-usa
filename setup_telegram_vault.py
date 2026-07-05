"""
One-time setup: store your Telegram bot token in an Anthropic Vault as an
environment_variable credential, so the apply-agent can send notifications
without the token ever appearing in its context, logs, or this chat.

Run this yourself — it prompts for the token with hidden input (getpass),
so it's never echoed to the terminal or captured by chat history.

Run: python3 setup_telegram_vault.py
"""

import getpass
import os

from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()


def main():
    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])

    token = getpass.getpass("Paste your Telegram bot token (hidden input): ").strip()
    chat_id = input("Paste your Telegram chat ID (not secret, ok to show): ").strip()

    if not token or not chat_id:
        print("Both values are required. Aborting.")
        return

    vault = client.beta.vaults.create(display_name="pm-jobs-apply-agent-secrets")
    print(f"Vault created: {vault.id}")

    client.beta.vaults.credentials.create(
        vault_id=vault.id,
        display_name="Telegram bot token",
        auth={
            "type": "environment_variable",
            "secret_name": "TELEGRAM_BOT_TOKEN",
            "secret_value": token,
            "networking": {
                "type": "limited",
                "allowed_hosts": ["api.telegram.org"],
            },
        },
    )
    print("Telegram bot token credential added to vault.")

    # chat_id is not sensitive — save it to .env for the agent's system prompt to reference
    with open(".env", "a") as f:
        f.write(f"\nTELEGRAM_CHAT_ID={chat_id}\n")
        f.write(f"ANTHROPIC_VAULT_ID={vault.id}\n")

    print()
    print(f"Vault ID: {vault.id}")
    print(f"Chat ID saved to .env as TELEGRAM_CHAT_ID")
    print("Done. Share the Vault ID (not the token) so the agent config can reference it.")


if __name__ == "__main__":
    main()
