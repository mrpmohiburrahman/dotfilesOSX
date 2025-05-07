#!/usr/bin/env bash
set -euo pipefail

# 1) Highlight stack items on hover
# # Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true # Enables hover highlight in Dock stacks :contentReference[oaicite:2]{index=2}

# 2) Icon size & magnification
# # Set the icon size of Dock items to 60 pixels
defaults write com.apple.dock tilesize -int 60 # Sets Dock icon size to 60 pixels :contentReference[oaicite:3]{index=3}
# # System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool true # Enables magnification on hover :contentReference[oaicite:4]{index=4}
# # System Preferences > Dock > Size (magnified):
defaults write com.apple.dock largesize -int 85 # Sets magnified icon size to 85 pixels :contentReference[oaicite:5]{index=5}

# 3) Minimize & animation effects
# defaults write com.apple.dock mineffect -string "scale" #genie #suck is the secret value that is not available on preferences
defaults write com.apple.dock mineffect -string "suck" # Uses “suck” for minimize/maximize :contentReference[oaicite:6]{index=6}
# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true # Minimize into app icon :contentReference[oaicite:7]{index=7}
# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1 # Speeds up Mission Control animations :contentReference[oaicite:8]{index=8}

# 4) Spring-loading & indicators
# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true # Spring-load Dock icons :contentReference[oaicite:9]{index=9}
# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true # Show open-app indicator lights :contentReference[oaicite:10]{index=10}

# 5) Spaces & auto-hide behavior
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false # Don’t auto-rearrange Spaces :contentReference[oaicite:11]{index=11}
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0 # Remove auto-hide delay :contentReference[oaicite:12]{index=12}
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5 # Shorten hide/show animation :contentReference[oaicite:13]{index=13}
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true # Enable auto-hide :contentReference[oaicite:14]{index=14}

# 6) Hidden & recent apps
# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true # Make hidden-app icons translucent :contentReference[oaicite:15]{index=15}
# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false # Disable Recent apps section :contentReference[oaicite:16]{index=16}

# 7) Apply changes
killall Dock # Restart Dock to apply all above settings :contentReference[oaicite:17]{index=17}
