#!/usr/bin/env sh
# icon.color=$LABEL_COLOR \
# label.color=$LABEL_COLOR \
sketchybar --add item calendar right \
    --set calendar icon=cal \
    icon.font="$FONT:Bold:14.0" \
    icon.padding_left=5 \
    icon.padding_right=5 \
    label.padding_left=5 \
    label.padding_right=5 \
    width=180 \
    align=center \
    background.color=$SPACE_BACKGROUND \
    background.height=26 \
    background.corner_radius=9
