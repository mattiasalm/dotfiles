#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Install from bundle files
_BUNDLES=("Brewfile")
if is-available brew; then
	for _BUNDLE in ${_BUNDLES}; do
		if brew bundle check --file="$DOTFILES_PATH/applications/$_BUNDLE" &>/dev/null; then
			color-print yellow "$_BUNDLE bundle ok"
		else
			brew bundle --file="$DOTFILES_PATH/applications/$_BUNDLE"
			color-print yellow "$_BUNDLE bundle installed/updated"
		fi
	done
else
	color-print red "Homebrew missing, needed for application installation"
fi

# Load PowerLevel10k from zshrc
color-print yellow "Add loading of PowerLevel10k theme"
replace-in-file "source.*zsh-theme" "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" $HOME/.zshrc
