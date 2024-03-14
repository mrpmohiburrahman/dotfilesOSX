#!/bin/bash

# Function to check if yabai is running
is_yabai_running() {
    pgrep -x "yabai" >/dev/null
    return $?
}

# Wait for yabai to start with a timeout of 5 minutes (300 seconds)
timeout=300 # 5 minutes in seconds
elapsed=0   # Time elapsed waiting for yabai to start

echo "Waiting for yabai to start..."
while ! is_yabai_running; do
    if [ "$elapsed" -ge "$timeout" ]; then
        echo "Timeout reached. yabai did not start within 5 minutes."
        exit 1
    fi
    sleep 1
    ((elapsed++))
done
echo "yabai has started."

# Wait for an additional 3 seconds before proceeding
sleep 3

# Variables
SCRIPT_NAME="openAppAndMove.sh"
LAUNCH_AGENT_LABEL="com.user.startupapps"
LAUNCH_AGENT_FILE="$HOME/Library/LaunchAgents/$LAUNCH_AGENT_LABEL.plist"
SCRIPT_PATH="$HOME/dotfilesOSX/startupScripts/$SCRIPT_NAME"

# Ensure the startup script exists and is executable
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Startup script does not exist. Please create $SCRIPT_PATH first."
    exit 1
fi

chmod +x "$SCRIPT_PATH"

# Create LaunchAgents directory if it doesn't exist
mkdir -p ~/Library/LaunchAgents

# Create Launch Agent plist file
cat >"$LAUNCH_AGENT_FILE" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$LAUNCH_AGENT_LABEL</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$SCRIPT_PATH</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

# Load the Launch Agent
launchctl unload "$LAUNCH_AGENT_FILE"

echo "Setup complete. $SCRIPT_NAME will now run at login."
