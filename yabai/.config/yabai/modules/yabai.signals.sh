#!/usr/bin/env bash
# —————————————————————————————————————————————————————————————————————————————
# (1) Load scripting additions on Big Sur+ and trigger your create_spaces script
# —————————————————————————————————————————————————————————————————————————————
# require passwordless sudo for `yabai --load-sa`
# Load scripting additions on Big Sur+ and hook create_spaces
sudo yabai --load-sa
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
yabai -m signal --add event=display_added action="sleep 1 && $HOME/dotfilesOSX/yabai/create_spaces.sh"
yabai -m signal --add event=display_removed action="sleep 1 && $HOME/dotfilesOSX/yabai/create_spaces.sh"

# SketchyBar triggers on window events
yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"

$HOME/dotfilesOSX/yabai/create_spaces.sh
