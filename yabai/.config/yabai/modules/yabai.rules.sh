#!/usr/bin/env bash
# Float special apps
for app in "System Preferences" "System Settings" "Karabiner-Elements" \
    "Karabiner-EventViewer" "Alfred Preferences" "System Information" \
    "CleanMyMac" "Setapp" "Flux" "Simulator" "Anki"; do
    yabai -m rule --add app="^${app}\$" sticky=on layer=above manage=off
done

# your fixed-space rules
yabai -m rule --add app="^Warp$" space=1 display=1
yabai -m rule --add app="^GoodTask$" space=2 display=1
yabai -m rule --add app="^Session$" space=3 display=1
yabai -m rule --add app="^SymlexVPN$" space=3 display=1
yabai -m rule --add app="^Messenger$" space=4 display=1
yabai -m rule --add app="^Discord$" space=4 display=1
yabai -m rule --add app="^Google Chrome$" space=5 display=2
yabai -m rule --add app="^Code$" space=6 display=2
yabai -m rule --add app="^Notion$" space=7 display=2

yabai -m rule --add label="Firfox PIP" app="^Firefox$" title="^(Picture-in-Picture)$" manage=off
