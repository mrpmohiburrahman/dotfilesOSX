#!/bin/dash

# Paths (adjust if necessary)
AERO="/opt/homebrew/bin/aerospace"
JQ="/opt/homebrew/bin/jq"

# 1. Query the focused window (always returns a one‐element array)
#    and extract its "window-id" field.
curWindowId="$(
    $AERO list-windows --focused --json |
        $JQ -re '.[0]["window-id"]'
)"

# 2. Move that window to the previous monitor (wrap around to last)
$AERO move-node-to-monitor \
    --window-id "$curWindowId" \
    --wrap-around prev

# 3. Refocus the moved window
$AERO focus --window-id "$curWindowId"
