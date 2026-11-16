#!/bin/bash -e

_CURRENT_DIR=$PWD
_TEMP_TARGET=$HOME/Downloads/dotfiles
_SOURCE="https://github.com/mattiasalm/dotfiles/tarball/master"

rm -rf $_TEMP_TARGET && mkdir $_TEMP_TARGET
curl -fLs $_SOURCE | tar -xz -C "$_TEMP_TARGET" --strip-components=1

# Stop if the download failed, without closing the terminal when this script is sourced
if [ ! -f $_TEMP_TARGET/install.sh ]; then
	echo "Error: Failed to download dotfiles from $_SOURCE"
	rm -rf $_TEMP_TARGET
	return 1
fi

# Change default shell to zsh, if needed
if [[ ! $SHELL =~ zsh ]]; then
	echo "Changing shell to:  zsh"
	chsh -s $(which zsh)
fi

cd $_TEMP_TARGET
zsh install.sh
cd $_CURRENT_DIR

# Make the dotfiles command available in the current shell, when this script is sourced
source $HOME/.dotfiles/system/.zsh-profile
