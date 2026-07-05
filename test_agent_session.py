"""
Smoke test: create a session against the apply-agent and ask it to send a
single test Telegram message. Validates the full chain — Agent, Environment,
and both Vault credentials (Telegram token, Supabase key) — before building
the real apply logic.

Run: python3 test_agent_session.py
"""

import os

from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()


def main():
    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])

    session = client.beta.sessions.create(
        agent={"type": "agent", "id": os.environ["ANTHROPIC_AGENT_ID"]},
        environment_id=os.environ["ANTHROPIC_ENVIRONMENT_ID"],
        vault_ids=[os.environ["ANTHROPIC_VAULT_ID"]],
        title="Smoke test",
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
                    "Send a Telegram message via curl saying exactly: "
                    "'Apply-agent smoke test successful.' Then also do a quick "
                    "SELECT on the candidate_profile table via the Supabase REST API "
                    "and tell me the full_name it returns. Report both results as text, "
                    "then stop — this is just a connectivity test, not a real apply run."
                ),
            }],
        }],
    )

    for event in stream:
        if event.type == "agent.message":
            for block in event.content:
                if block.type == "text":
                    print(block.text, end="", flush=True)
        elif event.type == "session.status_idle":
            if event.stop_reason.type != "requires_action":
                break
        elif event.type == "session.status_terminated":
            break
        elif event.type == "session.error":
            print(f"\n[ERROR] {event}")
            break

    print("\n\nDone. Check your Telegram for the test message.")


if __name__ == "__main__":
    main()
