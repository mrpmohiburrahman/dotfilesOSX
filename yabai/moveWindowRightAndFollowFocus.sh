#!/bin/dash

YABAI="/opt/homebrew/bin/yabai"
JQ="/opt/homebrew/bin/jq"

curWindowId="$($YABAI -m query --windows --window | jq -re ".id")"

$($YABAI -m window --display next || $YABAI -m window --display first)
$($YABAI -m window --focus "$curWindowId")
