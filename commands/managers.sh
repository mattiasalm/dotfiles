#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

echo
color-print blue "Checking Homebrew..."
if is-available brew; then
	color-print yellow "Homebrew already configured"
else
	color-print blue "Installing Homebrew..."
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

	if ! is-available brew; then
		echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ~/.zprofile
		eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
	fi

	color-print green "Homebrew installed successfully"
fi

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

echo
color-print blue "Checking Node.js..."
if is-available n; then
	# Set N_PREFIX to use Homebrew's Apple Silicon directory
	export N_PREFIX="/opt/homebrew"
	
	# Check current Node version
	_CURRENT_NODE=$(node --version 2>/dev/null || echo "none")
	
	# Get latest LTS version available (add 'v' prefix to match node --version format)
	_LATEST_LTS_RAW=$(n --lts 2>/dev/null || echo "none")
	if [ "$_LATEST_LTS_RAW" != "none" ]; then
		_LATEST_LTS="v$_LATEST_LTS_RAW"
	else
		_LATEST_LTS="none"
	fi
	
	if [ "$_CURRENT_NODE" = "none" ]; then
		color-print blue "Installing Node.js LTS..."
		n lts
		_NEW_NODE=$(node --version 2>/dev/null || echo "none")
		color-print green "Node.js installed successfully ($_NEW_NODE)"
	elif [ "$_CURRENT_NODE" != "$_LATEST_LTS" ]; then
		color-print blue "Updating Node.js: $_CURRENT_NODE → $_LATEST_LTS"
		n lts
		_NEW_NODE=$(node --version 2>/dev/null || echo "none")
		color-print green "Node.js updated successfully ($_NEW_NODE)"
	else
		color-print yellow "Node.js already up to date ($_CURRENT_NODE)"
	fi
else
	color-print red "Error: Node version manager required for Node.js installation"
	return 1
fi
