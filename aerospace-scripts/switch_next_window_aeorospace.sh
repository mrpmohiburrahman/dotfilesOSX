#!/usr/bin/env bash

# 1. Gather all Notion window IDs across all workspaces:
win_ids=($(
    aerospace list-windows --all --json |
        jq -r '.[] | select(.["app-name"]=="Notion") | .["window-id"]'
))

# 2. Exit if no Notion windows found
if [[ ${#win_ids[@]} -eq 0 ]]; then
    exit 1
fi

# 3. Define a cache file to store the last index
cache="$HOME/.cache/aerospace-notion-cycle-index"

# 4. Load last index (default to -1 so the first cycle is 0)
if [[ -f "$cache" ]]; then
    last_index=$(<"$cache")
else
    last_index=-1
fi

# 5. Compute the next index (wrap around)
next_index=$(((last_index + 1) % ${#win_ids[@]}))

# 6. Save the new index
echo "$next_index" >"$cache"

# 7. Focus the next Notion window
aerospace focus --window-id "${win_ids[$next_index]}"
