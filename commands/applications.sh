#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

echo
color-print blue "Checking application bundles..."
_BUNDLES=("Brewfile")
if is-available brew; then
	for _BUNDLE in ${_BUNDLES}; do
		if brew bundle check --file="$DOTFILES_PATH/applications/$_BUNDLE" &>/dev/null; then
			color-print yellow "$_BUNDLE already configured"
		else
			color-print blue "Installing applications from $_BUNDLE..."
			brew bundle --file="$DOTFILES_PATH/applications/$_BUNDLE"
			color-print green "$_BUNDLE applications installed successfully"
		fi
	done
else
	color-print red "Error: Homebrew required for application installation"
	return 1
fi

echo
color-print blue "Configuring Starship prompt..."
replace-in-file "eval.*starship init.*" "eval \"\$(starship init zsh)\"" $HOME/.zshrc

echo
color-print blue "Setting up Starship configuration..."
if [ ! -f $HOME/.config/starship.toml ]; then
    mkdir -p $HOME/.config
    cp $DOTFILES_PATH/config/starship.toml $HOME/.config/starship.toml
    color-print green "Starship configuration installed successfully"
else
    color-print yellow "Starship configuration already configured"
fi