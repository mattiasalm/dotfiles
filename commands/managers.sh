#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Install Homebrew
if is-available brew; then
	color-print yellow "Homebrew already installed"
else
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
	color-print yellow "Homebrew installed"
fi

# Install n
if is-available n; then
	color-print yellow "n already installed"
else
	if is-available brew; then
		brew install n
		color-print yellow "n installed"
	else
		color-print red "Homebrew is missing, needed for n installation"
	fi
fi

# Install npm
if is-available n; then
	n lts
	color-print yellow "npm and Node installed/updated"
else
	color-print red "n is missing, needed for npm and Node installation"
fi