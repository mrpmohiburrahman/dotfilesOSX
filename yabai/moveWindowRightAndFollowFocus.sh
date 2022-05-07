#!/bin/dash
curWindowId="$(/opt/homebrew/bin/yabai -m query --windows --window | jq -re ".id")"

$(/opt/homebrew/bin/yabai -m window --display next || /opt/homebrew/bin/yabai -m window --display first)
$(/opt/homebrew/bin/yabai -m window --focus "$curWindowId")