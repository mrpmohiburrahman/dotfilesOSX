#!/bin/dash

AERO="/opt/homebrew/bin/aerospace"
JQ="/opt/homebrew/bin/jq"

# 1. Fetch the focused window’s JSON (always a one-element array):
focused_json=$($AERO list-windows --focused --json)

# 2. Extract its window-id and app-name from the first object:
current_id=$(echo "$focused_json" | $JQ '.[0]["window-id"]')
current_app=$(echo "$focused_json" | $JQ -r '.[0]["app-name"]')

# 3. List all windows, filter by that app, and sort the IDs:
all_ids=$(
    $AERO list-windows --all --json |
        $JQ --arg app "$current_app" '
      [.[] 
       | select(."app-name" == $app) 
       | ."window-id"]
      | sort
    '
)

# 4. Compute the index of the next window (wrapping around):
total=$(
    echo "$all_ids" | $JQ 'length'
)
curr_index=$(
    echo "$all_ids" | $JQ --argjson id "$current_id" 'index($id)'
)
next_index=$(((curr_index + 1) % total))
next_id=$(
    echo "$all_ids" | $JQ ".[$next_index]"
)

# 5. Focus it (if we got a valid ID):
[ "$next_id" != "null" ] && $AERO focus --window-id "$next_id"
