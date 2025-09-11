#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

echo
color-print blue "Setting up Mackup configuration..."
_MACKUP_FILE=$DOTFILES_PATH/config/.mackup.cfg
if [ -f $_MACKUP_FILE ]; then
    cp $_MACKUP_FILE $HOME/.mackup.cfg
    color-print green "Mackup configuration installed successfully"
else
    color-print red "Error: Mackup config file not found"
    return 1
fi