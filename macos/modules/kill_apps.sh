########################################
# scripts/modules/kill_apps.sh
########################################
#!/usr/bin/env bash
kill_affected_applications() {
    local apps=(
        "Activity Monitor" "Address Book" "Calendar" "cfprefsd"
        "Contacts" "Dock" "Finder" "WindowManager"
        "Google Chrome" "Safari" "Mail" "Messages"
        "Terminal" "Transmission" "SystemUIServer"
    )
    for app in "${apps[@]}"; do
        killall "$app" &>/dev/null || true
    done
}
