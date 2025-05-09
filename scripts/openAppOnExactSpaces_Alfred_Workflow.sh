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
# openAppAndMove "iTerm" "iTerm2" 1
openAppAndMove "Warp" "" 1 1
# Open Discord and move it to the 4th space on display 1
openAppAndMove "Discord" "" 4 1
openAppAndMove "goodtask" "" 2 1
# openAppAndMove "Reminders" "" 3 1
# openAppAndMove "WhatsApp" "" 3 1
openAppAndMove "Messenger" "" 3 1

# openAppAndMove "Slack" "" 4 1

# openAppAndMove "Symlex" "" 4 1

openAppAndMove "Google Chrome" "" 5 2

# Open Urls in Chrome
urls=(
    "https://pahe.ink/"
    "https://psa.wf/"
    "https://fojik.com/genre/bollywood-hindi/"
    "https://www.facebook.com/messages/t/"
    "https://www.linkedin.com/"
    "https://news.ycombinator.com/"
    "https://youtube.com/"
)
openUrlsInChrome "${urls[@]}"

openAppAndMove "Visual Studio Code" "Code" 6 2
openAppAndMove "Notion" "" 7 2

# Open Discord and move it to the 4th space on display 1
# openAppAndMove "Discord" "" 4 1
