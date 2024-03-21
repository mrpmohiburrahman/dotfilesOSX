#!/bin/dash
# echo 'hi'

# curWindowId="$(jq -re ".id" <<<$(yabai -m query --windows --window))"

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

xx=$($YABAI -m query --windows --window)
curWindowId="$(echo $xx | jq -re ".id")"

focusWindow() {
    $($YABAI -m window --focus $1) # $1 is the first argument passed in (window id).
}
$($YABAI -m window --display prev || $YABAI -m window --display last)
focusWindow "$curWindowId"
# $YABAI -m window --toggle zoom-fullscreen
