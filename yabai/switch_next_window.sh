#!/bin/dash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

# Get the ID of the currently focused window
current_window=$($YABAI -m query --windows --window | $JQ '.id')

# Get the app of the currently focused window
current_app=$($YABAI -m query --windows --window | $JQ -r '.app')

# Get a sorted list of all window IDs for the current application
window_ids=$($YABAI -m query --windows | $JQ --arg app "$current_app" '[.[] | select(.app == $app) | .id] | sort')

# Get the total number of windows
total_windows=$(echo $window_ids | $JQ 'length')

# Get the index of the current window in the sorted list
current_index=$(echo $window_ids | $JQ --argjson current_window "$current_window" 'index($current_window)')

# Calculate the index of the next window (with wrapping)
next_index=$(((current_index + 1) % total_windows))

# Get the ID of the next window to focus
next_window=$(echo $window_ids | $JQ ".[$next_index]")

# Focus the next window
if [ "$next_window" != "null" ]; then
    $YABAI -m window --focus $next_window
fi
