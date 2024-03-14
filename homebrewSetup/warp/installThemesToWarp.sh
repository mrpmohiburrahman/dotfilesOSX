# macOS
WARP_THEMES_DIR="$HOME/dotfilesOSX/warp/.warp/themes"

# Linux
# WARP_THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes"

mkdir -p "$WARP_THEMES_DIR"
curl --output-dir "$WARP_THEMES_DIR" -LO https://raw.githubusercontent.com/catppuccin/warp/main/dist/catppuccin_latte.yml
curl --output-dir "$WARP_THEMES_DIR" -LO https://raw.githubusercontent.com/catppuccin/warp/main/dist/catppuccin_frappe.yml
curl --output-dir "$WARP_THEMES_DIR" -LO https://raw.githubusercontent.com/catppuccin/warp/main/dist/catppuccin_macchiato.yml
curl --output-dir "$WARP_THEMES_DIR" -LO https://raw.githubusercontent.com/catppuccin/warp/main/dist/catppuccin_mocha.yml
