########################################
# scripts/modules/ssd_tweaks.sh
########################################
#!/usr/bin/env bash
apply_ssd_tweaks() {
  # Disable hibernation for SSD
  sudo pmset -a hibernatemode 0
}