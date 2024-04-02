#!/bin/bash

# Function to wait for an app to launch and get its window ID using the query name
waitForApp() {
    local queryName="$1" # Use queryName to match the app name in yabai's window query
    local windowId
    while true; do
        # Try to get the window ID of the app using the query name
        windowId=$(yabai -m query --windows | jq -re ".[] | select(.app==\"$queryName\") | .id" | head -n 1)
        if [[ -n $windowId ]]; then
            # Output the window ID, which will be captured by the caller
            echo $windowId
            return # Exit the function after finding the window ID
        fi
        sleep 0.5
    done
}

# Function to open an app and move its window to a specific space.
# It now accepts an appName for opening the app, and optionally, a queryName for querying the window.
# If queryName is not provided, appName is used for querying.
openAppAndMove() {
    local appName="$1"
    local queryName="${2:-$1}" # If queryName is not provided, fall back to appName
    echo "$queryName"

    local spaceNumber="$3"
    open -a "$appName"
    # Capture the window ID from waitForApp using the query name or appName if queryName is not provided
    local windowId=$(waitForApp "$queryName")
    # Now, with the correct window ID, move the window
    yabai -m window "$windowId" --space "$spaceNumber"
    echo "$appName launched and moved to space $spaceNumber."
}

# Function to open URLs in Chrome. It now accepts an array of URLs as an argument.
openUrlsInChrome() {
    local urls=("$@") # Accept an array of URLs as argument
    for url in "${urls[@]}"; do
        open -a "Google Chrome" "$url"
    done
}

# Example usage:

# Open iTerm and move it to desktop 1. We need to specify "iTerm2" as the query name explicitly.
openAppAndMove "iTerm" "iTerm2" 1

# Open Reminders and move it to desktop 1. No need to specify "Reminders" as the query name explicitly.
openAppAndMove "Reminders" "" 3

# Open Google Chrome and move it to desktop 5
openAppAndMove "Google Chrome" "" 5

# Define your URLs here
urls=("https://pahe.ink/" "https://psa.wf/" "https://www.facebook.com/messages/t/" "https://www.linkedin.com/" "https://news.ycombinator.com/" "https://youtube.com/")

# Pass the URLs to the function
openUrlsInChrome "${urls[@]}"

# Open Visual Studio Code and move it to desktop 6
openAppAndMove "Visual Studio Code" "Code" 6

# Open Notion and move it to desktop 7
openAppAndMove "Notion" "" 7
