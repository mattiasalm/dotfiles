#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Install from bundle files
_BUNDLES=("Brewfile" "Caskfile")
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
_SHELL_RC_FILE=$HOME/.zshrc
_NEW_THEME_LOAD="source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme"
replace-in-file "source.*zsh-theme" $_NEW_THEME_LOAD $_SHELL_RC_FILE
