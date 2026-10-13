#!/usr/bin/env bash
# Renders a wireframe HTML file to a PNG next to it with headless Chrome.
# Usage: wireframe-png.sh FILE.html [WIDTHxHEIGHT]
# Size: the argument, else the page's <meta name="wf-size" content="WxH">, else 1440x900.
# Env: CHROME_BIN overrides the browser; WF_SCALE sets the device scale factor (default 1).
# Uses a throw-away profile, so it never touches the user's running browser.
set -u

HTML="${1:-}"
if [ -z "$HTML" ] || [ ! -f "$HTML" ]; then
  echo "usage: wireframe-png.sh FILE.html [WIDTHxHEIGHT]" >&2
  exit 1
fi

ABS="$(cd "$(dirname "$HTML")" && pwd)/$(basename "$HTML")"
OUT="${ABS%.*}.png"

SIZE="${2:-}"
if [ -z "$SIZE" ]; then
  SIZE=$(grep -o 'name="wf-size" content="[0-9]*x[0-9]*"' "$ABS" 2>/dev/null | grep -o '[0-9]*x[0-9]*' | head -1)
fi
SIZE="${SIZE:-1440x900}"
W="${SIZE%x*}"
H="${SIZE#*x}"

CHROME=""
if [ -n "${CHROME_BIN:-}" ] && [ -x "$CHROME_BIN" ]; then
  CHROME="$CHROME_BIN"
fi
if [ -z "$CHROME" ]; then
  for candidate in \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Chromium.app/Contents/MacOS/Chromium" \
    "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
    "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
    "$(command -v google-chrome 2>/dev/null)" \
    "$(command -v google-chrome-stable 2>/dev/null)" \
    "$(command -v chromium 2>/dev/null)" \
    "$(command -v chromium-browser 2>/dev/null)"; do
    if [ -n "$candidate" ] && [ -x "$candidate" ]; then
      CHROME="$candidate"
      break
    fi
  done
fi

if [ -z "$CHROME" ]; then
  echo "No Chrome or Chromium found. Open file://$ABS with the chrome-devtools MCP (new_page with background: true), save take_screenshot with fullPage: true and filePath: $OUT, then close_page." >&2
  exit 2
fi

PROFILE="$(mktemp -d)"
trap 'rm -rf "$PROFILE"' EXIT
rm -f "$OUT"

"$CHROME" --headless=new --disable-gpu --hide-scrollbars --no-first-run --no-default-browser-check \
  --user-data-dir="$PROFILE" --force-device-scale-factor="${WF_SCALE:-1}" \
  --virtual-time-budget=2000 --window-size="$W,$H" --screenshot="$OUT" "file://$ABS" >/dev/null 2>&1

if [ -s "$OUT" ]; then
  echo "$OUT"
else
  echo "Chrome did not write $OUT. Open file://$ABS with the chrome-devtools MCP (new_page with background: true), save take_screenshot with fullPage: true and filePath: $OUT, then close_page." >&2
  exit 3
fi
