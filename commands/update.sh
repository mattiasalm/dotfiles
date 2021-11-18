#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Run software update
. $(dirname $0)/prepare.sh

# Run Homebrew update
color-print yellow "Running Homebrew update"
if is-available brew; then
	brew update
	brew upgrade
	brew cleanup
else
	color-print red "Homebrew missing, needed for update"
fi

# Update node & NPM
# Install npm
if is-available n; then
	n lts
	color-print yellow "npm and Node updated"
else
	color-print red "n is missing, needed for npm and Node update"
fi