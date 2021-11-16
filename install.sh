#!/bin/zsh -e

setopt extendedglob

_DOTFILES_PATH=$HOME/.dotfiles
_SHELL_RC_FILE=$HOME/.zshrc

# Change default shell to zsh
# chsh -s $(which zsh)

# Clean .dotfiles path and copy files there
rm -rf $_DOTFILES_PATH
mkdir $_DOTFILES_PATH
cp -a ^install.sh $_DOTFILES_PATH

# Add or update .dotfiles binary path to $PATH in shell rc file
_NEW_PATH_EXPORT="export PATH=\$PATH:$_DOTFILES_PATH/bin"
if [ -f $_SHELL_RC_FILE ] && grep -q "export PATH=" "$_SHELL_RC_FILE"; then
	sed -n "s|export PATH.*$|$_NEW_PATH_EXPORT|g" $_SHELL_RC_FILE
else
	echo "\n$_NEW_PATH_EXPORT" >> $_SHELL_RC_FILE
fi

# Add or update .dotfiles path export in shell rc file
_NEW_DOTFILES_EXPORT="export DOTFILES_PATH=$_DOTFILES_PATH"
if [ -f $_SHELL_RC_FILE ] && grep -q "export DOTFILES_PATH=" "$_SHELL_RC_FILE"; then
	sed -n "s|export DOTFILES_PATH.*$|$_NEW_DOTFILES_EXPORT|g" $_SHELL_RC_FILE
else
	echo "\n$_NEW_DOTFILES_EXPORT" >> $_SHELL_RC_FILE
fi

# Execute shell rc file
. "${_SHELL_RC_FILE}"

# Make all files in .dotfiles binary path executable
_BINARY_FILES=($_DOTFILES_PATH/bin/*)
_BINARY_FILES+=($_DOTFILES_PATH/tools/*)
for _file in "${_BINARY_FILES[@]}"; do
	chmod +x $_file
done