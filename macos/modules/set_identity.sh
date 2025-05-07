########################################
# macos/modules/set_identity.sh
########################################
#!/usr/bin/env bash
set_identity() {
    # Identity
    sudo scutil --set ComputerName "$COMPUTER_NAME"
    sudo scutil --set HostName "$HOST_NAME"
    sudo scutil --set LocalHostName "$LOCAL_HOSTNAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$NETBIOS_NAME"
}
