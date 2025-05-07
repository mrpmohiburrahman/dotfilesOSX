#!/usr/bin/env bash
# Autostart apps with one-shot rules
declare -a AUTOSTART=(
    "Warp:1:1"
    "SymlexVPN:3:1"
    "Session:3:1"
    "Messenger:4:1"
    "Discord:4:1"
    "Visual Studio Code:6:2"
)

for entry in "${AUTOSTART[@]}"; do
    IFS=":" read -r app space display <<<"$entry"
    if ! pgrep -x "$app" >/dev/null; then
        yabai -m rule --add app="^${app//\//\\/}\$" space=$space display=$display --one-shot
        open -a "$app"
    fi
done

# Special-case Chrome + Notion with URLs
if ! pgrep -x "Google Chrome" &>/dev/null; then
    yabai -m rule --add app="^Google Chrome\$" space=5 display=2 --one-shot
    sleep 1 && open -a "Google Chrome" "https://pahe.ink/" "https://psa.wf/" "https://fojik.com/genre/bollywood-hindi/" "https://www.facebook.com/messages/t/" "https://www.linkedin.com/" "https://news.ycombinator.com/" "https://youtube.com/"
fi

if ! pgrep -x "Notion" &>/dev/null; then
    yabai -m rule --add app="^Notion\$" space=7 display=2 --one-shot
    sleep 1 && open -a "/Applications/Notion.app"
fi
