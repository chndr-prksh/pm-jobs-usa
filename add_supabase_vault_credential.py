"""
One-time setup: add the Supabase service role key to the same Vault as the
Telegram bot token, so the apply-agent can call Supabase's REST API without
the key ever appearing in its context or logs.

Reads SUPABASE_SERVICE_KEY / SUPABASE_URL from the local .env (already
present from earlier setup) — no re-entry needed.

Run: python3 add_supabase_vault_credential.py
"""

import os
from urllib.parse import urlparse

from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()


def main():
    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    vault_id = os.environ["ANTHROPIC_VAULT_ID"]

    supabase_host = urlparse(os.environ["SUPABASE_URL"]).hostname
    service_key = os.environ["SUPABASE_SERVICE_KEY"]

    client.beta.vaults.credentials.create(
        vault_id=vault_id,
        display_name="Supabase service key",
        auth={
            "type": "environment_variable",
            "secret_name": "SUPABASE_SERVICE_KEY",
            "secret_value": service_key,
            "networking": {
                "type": "limited",
                "allowed_hosts": [supabase_host],
            },
        },
    )
    print(f"Supabase service key credential added to vault {vault_id}, scoped to {supabase_host}")


if __name__ == "__main__":
    main()
