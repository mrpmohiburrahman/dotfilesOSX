########################################
# scripts/main.sh
########################################
#!/usr/bin/env bash
set -euo pipefail
# Load configuration
source "$(dirname "$0")/config/computer.conf"
source "$(dirname "$0")/config/hot_corners.conf"

# Load modules
source "$(dirname "$0")/modules/close_settings.sh"
source "$(dirname "$0")/modules/sudo_keepalive.sh"
source "$(dirname "$0")/modules/set_identity.sh"
source "$(dirname "$0")/modules/hot_corners.sh"
source "$(dirname "$0")/modules/general_ui.sh"
source "$(dirname "$0")/modules/ssd_tweaks.sh"
source "$(dirname "$0")/modules/input_tweaks.sh"
source "$(dirname "$0")/modules/kill_apps.sh"

# Execution
close_settings
ask_sudo
set_identity
apply_hot_corners
apply_general_ui
apply_ssd_tweaks
apply_input_tweaks
kill_affected_applications

echo "Done. Some changes may require logout/restart to take effect."
