#!/usr/bin/env bash
set -euo pipefail # abort on errors, undefined vars, or pipeline failures :contentReference[oaicite:4]{index=4}

# 1) Ensure dockutil is installed via Homebrew
if ! command -v dockutil &>/dev/null; then
    echo "Installing dockutil..."
    brew install dockutil # installs the CLI tool for Dock management :contentReference[oaicite:5]{index=5}
fi

# 2) Clear out all existing Dock items in one batch
dockutil --no-restart --remove all # removes every persistent-apps entry :contentReference[oaicite:6]{index=6}

# 3) Define the exact set of apps to pin
apps=(
    "/Applications/Google Chrome.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/Warp.app"
    "/Applications/Notion.app"
    "Applications/Simulator.app"
)

# 4) Add each app in the desired order, skipping missing bundles
for app in "${apps[@]}"; do
    if [[ -d "$app" ]]; then
        dockutil --no-restart --add "$app" # appends icon without restarting Dock each time :contentReference[oaicite:7]{index=7}
    else
        echo "Warning: $app not found, skipping"
    fi
done

# 5) Apply all changes at once
killall Dock # single restart for performance and fewer flickers :contentReference[oaicite:8]{index=8}
