########################################
# macos/modules/close_settings.sh
########################################
#!/usr/bin/env bash
close_settings() {
    # Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
    osascript -e 'tell application "System Preferences" to quit'
}
