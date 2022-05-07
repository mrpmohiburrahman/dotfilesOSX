#!/bin/dash
# echo 'hi'

# curWindowId="$(jq -re ".id" <<<$(yabai -m query --windows --window))"


xx=$(/opt/homebrew/bin/yabai -m query --windows --window)
curWindowId="$(echo $xx | jq -re ".id")"

focusWindow() {
    $(/opt/homebrew/bin/yabai -m window --focus $1) # $1 is the first argument passed in (window id).
}
$(/opt/homebrew/bin/yabai -m window --display prev || /opt/homebrew/bin/yabai -m window --display last)
focusWindow "$curWindowId"
# /opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen
