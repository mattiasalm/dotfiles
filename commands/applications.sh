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

# Add Starship loading
color-print yellow "Add loading of Starship"
replace-in-file "eval.*starship init.*" "eval \"\$(starship init zsh)\"" $HOME/.zshrc

# Copy Starship config
color-print yellow "Setting up Starship configuration"
if [ ! -f $HOME/.config/starship.toml ]; then
    mkdir -p $HOME/.config
    cp $DOTFILES_PATH/config/starship.toml $HOME/.config/starship.toml
fi