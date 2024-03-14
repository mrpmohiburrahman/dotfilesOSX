#!/bin/bash

appName="$1" # The name of the application to open, passed as an argument.

# Find the ID of the current display
currentDisplay=$(yabai -m query --displays --display | jq '.index')

# Function to check if there's an available space without windows in the current display
findNextAvailableSpaceInDisplay() {
    local displayId="$1"
    local spacesInDisplay=$(yabai -m query --spaces --display $displayId | jq -c '.[] | select(.windows | length == 0) | .index')

    # Return the first empty space found in the current display
    for space in $spacesInDisplay; do
        echo "$space"
        return
    done

    echo "0" # Indicates no empty space found
}

# Function to open the app in the next available or new space in the current display
openAppInNextOrNewSpaceInDisplay() {
    local displayId="$1"
    local nextAvailableSpace=$(findNextAvailableSpaceInDisplay $displayId)

    if [[ "$nextAvailableSpace" -ne "0" ]]; then
        # If there's an available space, focus that space and open the app
        yabai -m space --focus $nextAvailableSpace
        open -a "$appName"
    else
        # If no empty space is available, create a new space in the current display
        yabai -m display --focus $displayId
        yabai -m space --create
        # We need to focus on the newly created space which should be the last space in this display
        local newSpaceId=$(yabai -m query --spaces --display $displayId | jq '.[-1].index')
        yabai -m space --focus $newSpaceId
        open -a "$appName"
    fi
}

# Run the function with the current display
openAppInNextOrNewSpaceInDisplay $currentDisplay
