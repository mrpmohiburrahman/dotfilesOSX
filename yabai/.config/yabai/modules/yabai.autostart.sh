#!/usr/bin/env bash
# Autostart apps with one-shot rules
autostart_apps=(
    "Warp:1:1"
    "GoodTask:2:1"
    "SymlexVPN:3:1"
    "Session:3:1"
    "Messenger:4:1"
    "Discord:4:1"
    "Telegram:4:1"
    "WhatsApp:4:1"
    "Visual Studio Code:6:2"
)

for entry in "${autostart_apps[@]}"; do
    IFS=":" read -r app_name space display <<<"$entry"
    # only launch if not already running
    if ! pgrep -x "$app_name" >/dev/null; then
        # one-shot rule sends the next window to the right space/display
        yabai -m rule --add app="^${app_name//\//\\/}\$" space=$space display=$display --one-shot
        open -a "$app_name"
    fi
done

"Google Chrome:5:2"
# inside your for-loop, or standalone if you only want Notion:
if ! pgrep -x "Google Chrome" &>/dev/null; then
    # one-shot rule for the *next* Notion window
    yabai -m rule --add app="^Google Chrome$" space=5 display=2 --one-shot

    # give yabai a moment to register the rule, then open Notion
    sleep 1
    open -a "Google Chrome" "https://pahe.ink/" "https://psa.wf/" "https://fojik.com/genre/bollywood-hindi/" "https://www.facebook.com/messages/t/" "https://www.linkedin.com/" "https://news.ycombinator.com/" "https://youtube.com/" "https://twitter.com/home"
fi

# inside your for-loop, or standalone if you only want Notion:
if ! pgrep -x "Notion" &>/dev/null; then
    # one-shot rule for the *next* Notion window
    yabai -m rule --add app="^Notion$" space=7 display=2 --one-shot

    # give yabai a moment to register the rule, then open Notion
    sleep 1
    open -a "/Applications/Notion.app"
fi

# declare -a AUTOSTART=(
#     "Warp:1:1"
#     "SymlexVPN:3:1"
#     "Session:3:1"
#     "Messenger:4:1"
#     "Discord:4:1"
#     "Visual Studio Code:6:2"
# )

# for entry in "${AUTOSTART[@]}"; do
#     IFS=":" read -r app space display <<<"$entry"
#     if ! pgrep -x "$app" >/dev/null; then
#         yabai -m rule --add app="^${app//\//\\/}\$" space=$space display=$display --one-shot
#         open -a "$app"
#     fi
# done

# # Special-case Chrome + Notion with URLs
# if ! pgrep -x "Google Chrome" &>/dev/null; then
#     yabai -m rule --add app="^Google Chrome\$" space=5 display=2 --one-shot
#     sleep 1 && open -a "Google Chrome" "https://pahe.ink/" "https://psa.wf/" "https://fojik.com/genre/bollywood-hindi/" "https://www.facebook.com/messages/t/" "https://www.linkedin.com/" "https://news.ycombinator.com/" "https://youtube.com/"
# fi

# if ! pgrep -x "Notion" &>/dev/null; then
#     yabai -m rule --add app="^Notion\$" space=7 display=2 --one-shot
#     sleep 1 && open -a "/Applications/Notion.app"
# fi
