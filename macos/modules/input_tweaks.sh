########################################
# scripts/modules/input_tweaks.sh
########################################
#!/usr/bin/env bash
apply_input_tweaks() {
  # Trackpad: tap to click
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  # Disable natural scroll
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

  # Fast key repeat
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
}
