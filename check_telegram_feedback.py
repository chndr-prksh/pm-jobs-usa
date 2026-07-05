"""
Polls Telegram for button presses (Good/Flag) on submitted-application
notifications and records them in application_feedback.

Uses telegram_poll_state.last_update_id so repeated runs (e.g. on a cron
cadence) don't reprocess the same button press twice.

Run: python3 check_telegram_feedback.py
"""

import os

import psycopg2
import psycopg2.extras
import requests
from dotenv import load_dotenv

load_dotenv()


def get_conn():
    return psycopg2.connect(os.environ["SUPABASE_DB_URL"])


def get_last_update_id(conn) -> int:
    with conn.cursor() as cur:
        cur.execute("SELECT last_update_id FROM telegram_poll_state WHERE id = 1")
        row = cur.fetchone()
        return row[0] if row else 0


def set_last_update_id(conn, update_id: int):
    with conn.cursor() as cur:
        cur.execute(
            "UPDATE telegram_poll_state SET last_update_id = %s WHERE id = 1",
            (update_id,),
        )
    conn.commit()


def answer_callback_query(token: str, callback_query_id: str, text: str):
    requests.post(
        f"https://api.telegram.org/bot{token}/answerCallbackQuery",
        json={"callback_query_id": callback_query_id, "text": text},
        timeout=10,
    )


def edit_message_caption(token: str, chat_id, message_id, new_caption: str):
    requests.post(
        f"https://api.telegram.org/bot{token}/editMessageCaption",
        json={"chat_id": chat_id, "message_id": message_id, "caption": new_caption},
        timeout=10,
    )


def save_feedback(conn, application_id: str, feedback: str):
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO application_feedback (application_id, feedback) VALUES (%s, %s)",
            (application_id, feedback),
        )
    conn.commit()


def run():
    token = os.environ["TELEGRAM_BOT_TOKEN"]
    conn = get_conn()
    last_update_id = get_last_update_id(conn)

    resp = requests.get(
        f"https://api.telegram.org/bot{token}/getUpdates",
        params={"offset": last_update_id + 1, "timeout": 5},
        timeout=15,
    )
    resp.raise_for_status()
    updates = resp.json().get("result", [])

    print(f"Fetched {len(updates)} update(s) since update_id {last_update_id}")

    max_update_id = last_update_id
    processed = 0

    for update in updates:
        max_update_id = max(max_update_id, update["update_id"])
        cq = update.get("callback_query")
        if not cq:
            continue

        data = cq.get("data", "")
        if ":" not in data:
            continue
        action, application_id = data.split(":", 1)
        if action not in ("good", "flag"):
            continue

        feedback = "good" if action == "good" else "flagged"
        save_feedback(conn, application_id, feedback)
        processed += 1

        label = "✅ Marked good" if feedback == "good" else "🚩 Flagged for review"
        answer_callback_query(token, cq["id"], label)

        message = cq.get("message", {})
        old_caption = message.get("caption", "")
        edit_message_caption(
            token, message.get("chat", {}).get("id"), message.get("message_id"),
            f"{old_caption}\n\n{label}",
        )
        print(f"  {application_id}: {feedback}")

    if max_update_id != last_update_id:
        set_last_update_id(conn, max_update_id)

    conn.close()
    print(f"Processed {processed} feedback button press(es)")


if __name__ == "__main__":
    run()
