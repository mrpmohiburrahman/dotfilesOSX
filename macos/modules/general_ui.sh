########################################
# scripts/modules/general_ui.sh
########################################
#!/usr/bin/env bash
apply_general_ui() {
  # Save panels
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Quarantine dialog # Disable the “Are you sure you want to open this application?” dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Set sidebar icon size to medium ( default: 2)
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3
}
