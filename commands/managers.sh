#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

. $DOTFILES_PATH/commands/sub-commands/homebrew.sh

echo
color-print blue "Checking Node version manager..."
if is-available n; then
	color-print yellow "Node version manager already configured"
else
	if is-available brew; then
		color-print blue "Installing Node version manager..."
		brew install n
		color-print green "Node version manager installed successfully"
	else
		color-print red "Error: Homebrew required for Node version manager"
		return 1
	fi
fi

. $DOTFILES_PATH/commands/sub-commands/node.sh
