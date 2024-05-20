#!/bin/bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Ask for the administrator password upfront
sudo -v

# Check for Homebrew and install it if missing
if test ! $(which brew); then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/versions
brew tap Goles/battery
brew tap getantibody/tap
brew tap homebrew/bundle
brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew tap homebrew/core
brew tap mas-cli/tap

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install the Homebrew packages I use on a day-to-day basis.
brew bundle install --file=brewfile --verbose

# INSTAL CASK APPLICATIONS

# Install Caskroom and taps
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions
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

chmod +x ~/dotfilesOSX/startupScripts/setup_startup_script.sh

# instal lwarp theme
sh ~/dotfilesOSX/homebrewSetup/warp/installThemesToWarp.sh

# clone this repo and install the fonts for sketchybar https://github.com/kvndrsslr/sketchybar-app-font
