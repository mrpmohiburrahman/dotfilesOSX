#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Taps
brew tap Goles/battery   # battery status tools
brew tap getantibody/tap # antibody plugin manager
brew tap mas-cli/tap     # Mac App Store CLI tools

# Update & upgrade
brew update  # fetch latest list of formulae :contentReference[oaicite:3]{index=3}
brew upgrade # upgrade installed formulae

# Install formulas from Brewfile (absolute path)
brew bundle install --file="$HOME/dotfilesOSX/homebrewSetup/formulas" --verbose # use specific Brewfile :contentReference[oaicite:4]{index=4}

# Cask taps & installs
brew install brew-cask # install brew-cask helper
brew tap wix/brew      # tap for applesimutils via wix :contentReference[oaicite:5]{index=5}
brew tap FelixKratz/formulae
brew bundle install --file=~/dotfilesOSX/homebrewSetup/casks --verbose # install casks :contentReference[oaicite:6]{index=6}

# Cleanup outdated versions
brew cleanup # remove old versions :contentReference[oaicite:7]{index=7}

# Switch to latest Node LTS
sudo n lts # upgrade Node LTS via n

# Install Warp theme
bash "$HOME/dotfilesOSX/homebrewSetup/warp/installThemesToWarp.sh"

# Finally, execute the macOS-specific setup
bash "$HOME/dotfilesOSX/macos/main.sh" # run additional macOS configuration script :contentReference[oaicite:8]{index=8}

if command -v xcodes >/dev/null 2>&1; then
    echo "💿 xcodes found — installing latest Xcode…"
    xcodes install --latest --experimental-unxip
else
    echo "⚠️ xcodes CLI not installed; skipping Xcode install"
fi

# symbolic link

# ln -nfs ~/dotfilesOSX/.zshrc ~/.zshrc
# ln -nfs ~/dotfilesOSX/.zprofile ~/.zprofile
# ln -nfs ~/dotfilesOSX/karabiner.json ~/.config/karabiner/karabiner.json
# ln -s ~/bin/dotfiles/ZSH_THEME/mrp.zsh-theme ~/.oh-my-zsh/custom/themes/mrp.zsh-theme
# ln -nfs ~/dotfilesOSX/.yabairc ~/.yabairc
# ln -nfs ~/dotfilesOSX/.fzf.zsh ~/.fzf.zsh

# Modular Dock configuration
# bash "$HOME/dotfilesOSX/macos/add-dock-items.sh"
# bash "$HOME/dotfilesOSX/macos/dock_settings.sh"
# macos/main.sh
