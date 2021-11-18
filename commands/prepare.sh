#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Run software update
color-print yellow "Running software update"
sudo softwareupdate --install --all

# Install Xcode (includes other things such as git)
color-print yellow "Installing Xcode"
xcode-select --install
