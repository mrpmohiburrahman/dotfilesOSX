#!/bin/bash

# Get the ID of the currently focused window
current_window=$(yabai -m query --windows --window | jq '.id')

# Get the app of the currently focused window
current_app=$(yabai -m query --windows --window | jq -r '.app')

# Get the list of all windows for the current application, then find the next window ID
next_window=$(yabai -m query --windows | jq --arg app "$current_app" --argjson current_window "$current_window" '[.[] | select(.app == $app) | .id] | sort | [.[], .[0]] | unique | .[index($current_window)+1]')

# Focus the next window
if [ "$next_window" != "null" ]; then
    yabai -m window --focus $next_window
fi
