#!/usr/bin/env bash
# Float special apps
for app in "System Preferences" "System Settings" "Karabiner-Elements" \
    "Karabiner-EventViewer" "Alfred Preferences" "System Information" \
    "CleanMyMac" "Setapp" "Flux" "Simulator" "Anki"; do
    yabai -m rule --add app="^${app}\$" sticky=on layer=above manage=off
done

# Fixed-space rules
declare -A FIXED_RULES=(
    ["Warp"]="1:1"
    ["Session"]="3:1"
    ["SymlexVPN"]="3:1"
    ["Messenger"]="4:1"
    ["Discord"]="4:1"
    ["Google Chrome"]="5:2"
    ["Code"]="6:2"
    ["Notion"]="7:2"
)
for app in "${!FIXED_RULES[@]}"; do
    IFS=":" read -r space display <<<"${FIXED_RULES[$app]}"
    yabai -m rule --add app="^${app}\$" space=$space display=$display
done

yabai -m rule --add label="Firfox PIP" app="^Firefox$" title="^(Picture-in-Picture)$" manage=off
