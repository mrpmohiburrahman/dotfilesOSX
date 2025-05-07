#!/usr/bin/env bash
# Global yabai settings
yabai -m config layout bsp       # BSP tiling :contentReference[oaicite:10]{index=10}
yabai -m config split_ratio 0.50 # Equal splits
yabai -m config auto_balance on  # Auto-balance tree
yabai -m config mouse_follows_focus off
yabai -m config focus_follows_mouse off
yabai -m config window_gap 6
yabai -m config top_padding 3 bottom_padding 3
yabai -m config left_padding 3 right_padding 3
yabai -m config window_shadow off
yabai -m config window_opacity off # disable transparency
yabai -m config active_window_opacity 1.0
yabai -m config normal_window_opacity 1.0
yabai -m config insert_feedback_color 0xff9dd274
yabai -m config window_origin_display default
yabai -m config window_placement second_child
yabai -m config window_topmost off
yabai -m config window_opacity_duration 0.0
yabai -m config window_border_blur off # other wise some window like system settings or karabinar elements gets blurred
yabai -m config external_bar all:39:0
