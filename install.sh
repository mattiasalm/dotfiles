#!/bin/zsh -e

setopt extendedglob

_DOTFILES_PATH=$HOME/.dotfiles
_SHELL_RC_FILE=$HOME/.zshrc

# Change default shell to zsh, if needed
if [[ ! $SHELL =~ zsh ]]; then
	echo "Changing shell to:  zsh"
	chsh -s $(which zsh)
fi

# Clean .dotfiles path and copy files there
rm -rf $_DOTFILES_PATH
mkdir -p $_DOTFILES_PATH
cp -a ^*install.sh $_DOTFILES_PATH

# Make all files in .dotfiles binary path executable
_BINARY_FILES=($_DOTFILES_PATH/bin/*)
_BINARY_FILES+=($_DOTFILES_PATH/tools/*)
for _file in ${_BINARY_FILES[@]}; do
	chmod +x $_file
done

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Add or update .dotfiles binary path to $PATH in shell rc file
_NEW_PATH_EXPORT="export PATH=\$PATH:$_DOTFILES_PATH/bin"
replace-in-file "export PATH.*$" $_NEW_PATH_EXPORT $_SHELL_RC_FILE

# Add or update .dotfiles path export in shell rc file
_NEW_DOTFILES_EXPORT="export DOTFILES_PATH=$_DOTFILES_PATH"
replace-in-file "export DOTFILES_PATH.*$" $_NEW_DOTFILES_EXPORT $_SHELL_RC_FILE

# Execute shell rc file
. $_SHELL_RC_FILE

color-print green "\ndotfiles installation successful!\n"

dotfiles