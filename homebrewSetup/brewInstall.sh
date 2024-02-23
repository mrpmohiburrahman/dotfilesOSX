#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

export PATH="/opt/homebrew/bin:$PATH"

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
#if test ! $(which brew); then
# echo "Installing Homebrew..."
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null

#fi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null

brew tap homebrew/bundle
brew tap homebrew/cask-fonts # fonts for sketchybar
brew tap mas-cli/tap

brew tap FelixKratz/formulae # for sketchybar

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install the Homebrew packages I use on a day-to-day basis.
brew bundle install --file=brewfile --verbose

# Install Caskroom and taps
# brew tap caskroom/cask #Error: caskroom/cask was moved. Tap homebrew/cask instead.
brew install brew-cask
#brew tap caskroom/versions #Error: caskroom/versions was moved. Tap homebrew/cask-versions instead.
brew tap wix/brew # for applesimutis

# for jdk from zulu 11
brew tap homebrew/cask-versions

brew bundle install --file=brewflieCask --verbose

# Remove outdated versions from the cellar
brew cleanup

sudo n lts
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
xattr -r -d com.apple.quarantine /Applications

# !/usr/bin/env bash

# sudo xcode-select --switch /Applications/Xcode.app
# brew install robotsandpencils/made/xcodes

# For react native android

chmod +x ~/dotfilesOSX/customize_macos.sh

~/dotfilesOSX/customize_macos.sh
