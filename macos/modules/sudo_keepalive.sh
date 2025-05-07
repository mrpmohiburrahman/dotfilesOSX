########################################
# scripts/modules/sudo_keepalive.sh
########################################
#!/usr/bin/env bash
# Ask for sudo once, then keep it alive
ask_sudo() {
    sudo -v
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
}
