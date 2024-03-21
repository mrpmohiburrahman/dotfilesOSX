#!/bin/bash

# Path to Yabai and JQ
YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

# Get the ID of the currently focused window
current_window_id=$($YABAI -m query --windows --window | $JQ -r '.id')

# Exit if no window is focused
if [ "$current_window_id" = "null" ]; then
    echo "No focused window."
    exit 1
fi

# Get the current display ID and space ID
current_display_id=$($YABAI -m query --windows --window | $JQ -r '.display')
current_space_index=$($YABAI -m query --spaces --space | $JQ -r '.index')

# Get an array of space IDs for the current display
space_ids_on_display=($($YABAI -m query --spaces --display $current_display_id | $JQ -r '.[].index'))

# Find the position of the current space within the array
for i in "${!space_ids_on_display[@]}"; do
    if [[ "${space_ids_on_display[$i]}" = "${current_space_index}" ]]; then
        current_space_array_position=$i
        break
    fi
done

# Determine the target space based on the current position
if [ "$current_space_array_position" -eq 0 ]; then
    # If on the first space, find the last space of the other display
    displays=($($YABAI -m query --displays | $JQ -r '.[].index'))
    for d in "${displays[@]}"; do
        if [ "$d" != "$current_display_id" ]; then
            other_display_id=$d
            break
        fi
    done
    target_space=$($YABAI -m query --spaces --display $other_display_id | $JQ -r '.[-1].index')
else
    # Move to the immediate previous space on the same display
    let "target_space_position=current_space_array_position-1"
    target_space=${space_ids_on_display[$target_space_position]}
fi

# Move the current window to the target space
$YABAI -m window $current_window_id --space $target_space

# Focus on the window and switch to the target space. Comment out the line below to disable this behavior.
# $YABAI -m space --focus $target_space

# Optionally focus on the next window in the current space (if any)
$YABAI -m window --focus next || $YABAI -m window --focus prev
