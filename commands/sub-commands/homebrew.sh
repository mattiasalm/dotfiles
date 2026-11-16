#!/bin/zsh -e

# Homebrew installation and package management
# This script handles Homebrew installation and package updates

echo
color-print blue "Checking Homebrew..."
if is-available brew; then
	# Check for outdated packages first
	_OUTDATED=$(brew outdated --quiet | wc -l | tr -d ' ')
	if [ "$_OUTDATED" -gt 0 ]; then
		color-print blue "$_OUTDATED packages available for update"
		color-print blue "Updating Homebrew packages..."
		brew update
		brew upgrade
		brew cleanup
		color-print green "Homebrew packages updated successfully"
	else
		color-print green "Homebrew packages up to date"
	fi
else
	color-print blue "Installing Homebrew..."
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	if ! is-available brew; then
		echo >> ~/.zprofile
		echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv zsh)"
	fi

	color-print green "Homebrew installed successfully"
fi
