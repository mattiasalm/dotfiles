#!/bin/bash -e

_CURRENT_DIR=$PWD
_TEMP_TARGET=$HOME/Downloads/dotfiles
_SOURCE="https://github.com/mattiasalm/dotfiles/tarball/master"

rm -rf $_TEMP_TARGET && mkdir $_TEMP_TARGET
curl -Ls $_SOURCE | tar -xz -C "$_TEMP_TARGET" --strip-components=1

# Change default shell to zsh, if needed
if [[ ! $SHELL =~ zsh ]]; then
	echo "Changing shell to:  zsh"
	chsh -s $(which zsh)
fi

cd $_TEMP_TARGET
zsh install.sh
cd $_CURRENT_DIR