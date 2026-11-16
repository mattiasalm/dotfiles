#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

_BUNDLE_FAILED=0

echo
color-print blue "Checking application bundles..."
_BUNDLES=("Brewfile")
if is-available brew; then
	for _BUNDLE in ${_BUNDLES}; do
		if brew bundle check --file="$DOTFILES_PATH/applications/$_BUNDLE" &>/dev/null; then
			color-print yellow "$_BUNDLE already configured"
		else
			color-print blue "Installing applications from $_BUNDLE..."
			if brew bundle --file="$DOTFILES_PATH/applications/$_BUNDLE"; then
				color-print green "$_BUNDLE applications installed successfully"
			else
				color-print red "Error: Some applications from $_BUNDLE failed to install"
				_BUNDLE_FAILED=1
			fi
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
mkdir -p $HOME/.config
if [ -f $HOME/.config/starship.toml ]; then
    color-print yellow "Overwriting existing Starship configuration..."
fi
cp $DOTFILES_PATH/config/starship.toml $HOME/.config/starship.toml
color-print green "Starship configuration installed successfully"

echo
color-print blue "Setting up Ghostty configuration..."
mkdir -p $HOME/.config/ghostty
if [ -f $HOME/.config/ghostty/config.ghostty ]; then
    color-print yellow "Overwriting existing Ghostty configuration..."
fi
cp $DOTFILES_PATH/config/ghostty-config $HOME/.config/ghostty/config.ghostty
color-print green "Ghostty configuration installed successfully"

# Report failed application installs, after the configuration above has been set up
return $_BUNDLE_FAILED
