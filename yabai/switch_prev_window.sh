#!/bin/dash

# Get the ID of the currently focused window
current_window=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq '.id')

# Get the app of the currently focused window
current_app=$(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.app')

# Get a sorted list of all window IDs for the current application
window_ids=$(/opt/homebrew/bin/yabai -m query --windows | /opt/homebrew/bin/jq --arg app "$current_app" '[.[] | select(.app == $app) | .id] | sort')

# Get the total number of windows
total_windows=$(echo $window_ids | /opt/homebrew/bin/jq 'length')

# Get the index of the current window in the sorted list
current_index=$(echo $window_ids | /opt/homebrew/bin/jq --argjson current_window "$current_window" 'index($current_window)')

# Calculate the index of the previous window (with wrapping)
prev_index=$(((current_index - 1 + total_windows) % total_windows))

# Get the ID of the previous window to focus
prev_window=$(echo $window_ids | /opt/homebrew/bin/jq ".[$prev_index]")

# Focus the previous window
if [ "$prev_window" != "null" ]; then
    /opt/homebrew/bin/yabai -m window --focus $prev_window
fi
