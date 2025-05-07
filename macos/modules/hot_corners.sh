########################################
# scripts/modules/hot_corners.sh
########################################
#!/usr/bin/env bash
apply_hot_corners() {
    # Ensure variables TL, TR, BL, BR are set
    : "${TL:?TL is not set in config/hot_corners.conf}"
    : "${TR:?TR is not set in config/hot_corners.conf}"
    : "${BL:?BL is not set in config/hot_corners.conf}"
    : "${BR:?BR is not set in config/hot_corners.conf}"

    defaults write com.apple.dock wvous-tl-corner -int "$TL"
    defaults write com.apple.dock wvous-tr-corner -int "$TR"
    defaults write com.apple.dock wvous-bl-corner -int "$BL"
    defaults write com.apple.dock wvous-br-corner -int "$BR"
    killall Dock
}
