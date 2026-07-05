"""
Replaces the Vault-based Telegram token with a plain local credential.

Telegram's Bot API embeds the token directly in the URL path
(.../bot<TOKEN>/sendMessage), which Vault environment_variable credentials
can't substitute into (they only support header/body injection). Since a
Telegram bot token is low-stakes (revocable instantly via @BotFather, scoped
only to sending messages through that one bot), we store it as a plain local
env var instead and pass it to each session's initial instructions directly.

Run: python3 setup_telegram_plain.py
"""

import getpass


def main():
    token = getpass.getpass("Paste your Telegram bot token (hidden input): ").strip()
    if not token:
        print("No token entered. Aborting.")
        return

    with open(".env", "a") as f:
        f.write(f"\nTELEGRAM_BOT_TOKEN={token}\n")

    print("Saved TELEGRAM_BOT_TOKEN to .env (local only, gitignored).")


if __name__ == "__main__":
    main()
