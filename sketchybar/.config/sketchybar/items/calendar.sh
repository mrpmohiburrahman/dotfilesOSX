#!/usr/bin/env sh

sketchybar --add item calendar right \
    --set calendar icon=cal \
    icon.color=$LABEL_COLOR \
    icon.font="$FONT:Bold:14.0" \
    icon.padding_left=5 \
    icon.padding_right=5 \
    label.color=$LABEL_COLOR \
    label.padding_left=5 \
    label.padding_right=5 \
    width=180 \
    align=center \
    background.color=$SPACE_BACKGROUND \
    background.height=26 \
    background.corner_radius=9
