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

# Get the ID of the display containing the currently focused window
current_display_id=$($YABAI -m query --windows --window | $JQ -r '.display')

# Get an array of space IDs for the current display
space_ids_on_display=($($YABAI -m query --spaces --display $current_display_id | $JQ -r '.[].index'))

# Find the index of the currently focused space within the array of space IDs
current_space_index=$($YABAI -m query --spaces --space | $JQ -r '.index')
for i in "${!space_ids_on_display[@]}"; do
    if [[ "${space_ids_on_display[$i]}" = "${current_space_index}" ]]; then
        current_space_array_index=$i
        break
    fi
done

# Determine if the current space is the last space on the display
if [ $current_space_array_index -eq $((${#space_ids_on_display[@]} - 1)) ]; then
    # Create a new space on the current display
    $YABAI -m space --create
    # Move the current window to the newly created space
    # Note: There's a small delay to ensure the new space is created before moving the window
    sleep 0.5
    new_space_index=$($YABAI -m query --spaces --display $current_display_id | $JQ -r '.[-1].index')
    $YABAI -m window $current_window_id --space $new_space_index
else
    # Move the current window to the next space on the same display
    next_space_index=${space_ids_on_display[$current_space_array_index + 1]}
    $YABAI -m window $current_window_id --space $next_space_index
fi

# Focus on the window after moving it
$YABAI -m window --focus $current_window_id
