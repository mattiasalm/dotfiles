#!/bin/zsh -e

# Change default shell to zsh, if needed
if [[ ! $SHELL =~ zsh ]]; then
	echo "Changing shell to:  zsh"
	chsh -s $(which zsh)
fi

# Older installs symlinked .zshrc into .dotfiles, turn it into a real file so its content survives the cleanup below
if [ -L $HOME/.zshrc ]; then
	cat $HOME/.zshrc > $HOME/.zshrc-migrated 2> /dev/null || true
	mv $HOME/.zshrc-migrated $HOME/.zshrc
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

# Tools rely on DOTFILES_PATH, which the shell rc file does not provide yet on a first install
export DOTFILES_PATH=$HOME/.dotfiles

# Load the dotfiles shell profile from the shell rc file, which stays the user's own file
$HOME/.dotfiles/tools/replace-in-file "source .*/\.zsh-profile" "source $HOME/.dotfiles/system/.zsh-profile" $HOME/.zshrc

# Execute the dotfiles shell profile
source $HOME/.dotfiles/system/.zsh-profile

$HOME/.dotfiles/tools/is-available dotfiles && \
$HOME/.dotfiles/tools/color-print green "\ndotfiles installation successful!\n"

dotfiles