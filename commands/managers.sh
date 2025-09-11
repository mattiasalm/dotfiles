#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Install Homebrew
if is-available brew; then
	color-print yellow "Homebrew already installed"
else
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

	if ! is-available brew; then
			echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ~/.zprofile
			eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
	fi

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

# Install Node and npm
if is-available n; then
	# Set N_PREFIX to use Homebrew's Apple Silicon directory
	export N_PREFIX="/opt/homebrew"
	
	n lts
	color-print yellow "npm and Node installed/updated"
else
	color-print red "n is missing, needed for npm and Node installation"
fi
