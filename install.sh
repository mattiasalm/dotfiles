#!/bin/zsh -e

# Change default shell to zsh, if needed
if [[ ! $SHELL =~ zsh ]]; then
	echo "Changing shell to:  zsh"
	chsh -s $(which zsh)
fi

# Clean .dotfiles path and copy files there
rm -rf $HOME/.dotfiles
mkdir -p $HOME/.dotfiles
cp -r * $HOME/.dotfiles
rm -rf $HOME/.dotfiles/install.sh

# Make all files in .dotfiles binary path executable
_BINARY_FILES=($HOME/.dotfiles/bin/*)
_BINARY_FILES+=($HOME/.dotfiles/tools/*)
for _file in ${_BINARY_FILES[@]}; do
	chmod +x $_file
done

# Include tools as binary functions
export PATH=$PATH:$HOME/.dotfiles/tools
echo $PATH

# Symlink .zsh-profile
if [ ! -L $HOME/.zshrc ] && [ -e $HOME/.zshrc ]; then
	mv $HOME/.zshrc $HOME/.zshrc-backup
fi
ln -sf $HOME/.dotfiles/system/.zsh-profile $HOME/.zshrc

# Add or update .dotfiles binary path to $PATH in shell rc file
$HOME/.dotfiles/tools/replace-in-file "export\ PATH.*$" "export PATH=\$PATH:$HOME/.dotfiles/bin" $HOME/.zshrc

# Add or update .dotfiles path export in shell rc file
$HOME/.dotfiles/tools/replace-in-file "export DOTFILES_PATH.*$" "export DOTFILES_PATH=$HOME/.dotfiles" $HOME/.zshrc

# Add additional dotfiles
_DOTFILES=("alias")
for _DOTFILE in $_DOTFILES; do
	_FILE=$HOME/.dotfiles/system/.$_DOTFILE
	$HOME/.dotfiles/tools/replace-in-file "source *.$_DOTFILE" "source $_FILE" $HOME/.zshrc
done

# Execute shell rc file
source $HOME/.zshrc

$HOME/.dotfiles/tools/is-available dotfiles && \
$HOME/.dotfiles/tools/color-print green "\ndotfiles installation successful!\n"

dotfiles