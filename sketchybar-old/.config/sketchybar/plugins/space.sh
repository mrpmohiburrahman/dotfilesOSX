#!/bin/bash

update() {
  source "$HOME/.config/sketchybar/colors.sh"
  COLOR=$BACKGROUND_2
  if [ "$SELECTED" = "true" ]; then
    COLOR=$GREY
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
    label.highlight=$SELECTED \
    background.border_color=$COLOR
}

# Function to switch spaces using AppleScript
switch_space_with_applescript() {
  local space_number=$1
  # Key codes for numbers 1-9 and 0 in sequence. Adjust if you have more than 10 spaces.
  local key_codes=("18" "19" "20" "21" "23" "22" "26" "28" "25" "29")
  local key_code=${key_codes[$space_number - 1]}

  if [[ -n $key_code ]]; then
    osascript -e "tell application \"System Events\" to key code $key_code using control down"
  else
    echo "Space number $space_number is out of the predefined range."
  fi
}

#  Check if yabai scripting addition is running
yabai_scripting_addition_active() {
  # Attempt a command that requires the scripting addition and check for a specific failure message.
  yabai -m query --spaces >/dev/null 2>&1
  return $?
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger windows_on_spaces --trigger space_change
  else
    ### yabai -m space --focus $SID 2>/dev/null
    if ! yabai -m space --focus $SID 2>/dev/null; then
      # Fallback to AppleScript if yabai cannot switch space
      switch_space_with_applescript $SID
    else
      # Scripting addition is active, use yabai to focus space
      yabai -m space --focus $SID 2>/dev/null
    fi
  fi
}

case "$SENDER" in
"mouse.clicked")
  mouse_clicked
  ;;
*)
  update
  ;;
esac
