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

# Add oh-my-posh loading
color-print yellow "Add loading of oh-my-posh"
replace-in-file "eval .*oh-my-posh\.json)\"" "eval \"\$(oh-my-posh init zsh --config ~/.dotfiles/config/oh-my-posh.json)\"" $HOME/.zshrc