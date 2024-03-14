#!/bin/bash

# source "$HOME/.config/sketchybar/icons.sh"

TextInputMenuAgent=(
    padding_right=7
    label.width=0
)

# sketchybar --add item wifi right \
#   --set wifi "${wifi[@]}" \
#   --subscribe wifi wifi_change mouse.clicked
sketchybar --add alias TextInputMenuAgent right \
    --set TextInputMenuAgent "${TextInputMenuAgent[@]}"
