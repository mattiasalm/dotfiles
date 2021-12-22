#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Mackup config
color-print yellow "Restore Mackup config file"
_MACKUP_FILE=$DOTFILES_PATH/config/.mackup.cfg
[ -f $_MACKUP_FILE ] && cp $_MACKUP_FILE $HOME/.mackup.cfg