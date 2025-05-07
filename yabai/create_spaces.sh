
#!/usr/bin/env sh
# ~/dotfilesOSX/yabai/create_spaces.sh
# Ensure exactly 4 spaces on every monitor.

DESIRED=4

# 1) For each display object from `yabai -m query --displays`…
yabai -m query --displays | jq -c '.[]' | while read -r disp; do
  # 2) Extract its arrangement index
  idx=$(jq -r '.index' <<<"$disp")                            # :contentReference[oaicite:3]{index=3}

  # 3) How many spaces it currently has
  count=$(jq -r '.spaces | length' <<<"$disp")                # :contentReference[oaicite:4]{index=4}

  # 4) Difference from our target
  delta=$(( DESIRED - count ))

  if [ "$delta" -gt 0 ]; then
    # 5) To add spaces: focus display, then create on active display
    for _ in $(seq 1 $delta); do
      yabai -m display --focus "$idx"                           # :contentReference[oaicite:5]{index=5}
      yabai -m space --create                                   # :contentReference[oaicite:6]{index=6}
    done

  elif [ "$delta" -lt 0 ]; then
    # 6) To remove spaces: destroy by mission-control index
    for _ in $(seq 1 $(( -delta ))); do
      space_idx=$(
        yabai -m query --spaces --display "$idx"                # :contentReference[oaicite:7]{index=7}
        | jq -r '.[-1].index'
      )
      yabai -m space --destroy "$space_idx"                     # :contentReference[oaicite:8]{index=8}
    done
  fi
done

# 7) Trigger your bar (e.g. SketchyBar) to update
sketchybar --trigger space_change --trigger windows_on_spaces   # :contentReference[oaicite:9]{index=9}
