#!/bin/bash
# Launches Chrome with remote debugging on, so assist.py can attach to your
# real browser session and prefill job forms. Uses a dedicated profile dir
# so it won't disturb your normal Chrome windows.
#
# Usage:  ./launch_assist_chrome.sh
# Then log in / open a job, click Apply, and run:  python3 assist.py

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
PROFILE_DIR="$HOME/.chrome-assist"

if [ ! -f "$CHROME" ]; then
  echo "Chrome not found at: $CHROME"
  echo "Edit this script's CHROME path to match your install."
  exit 1
fi

echo "Launching Chrome (assist profile) with remote debugging on port 9222..."
echo "Log into the sites you apply through, open a job, click Apply, then run: python3 assist.py"
"$CHROME" \
  --remote-debugging-port=9222 \
  --user-data-dir="$PROFILE_DIR" \
  >/dev/null 2>&1 &
