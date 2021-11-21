#!/bin/zsh -e

# Mackup config
_MACKUP_FILE=$DOTFILES_PATH/config/.mackup.cfg
[ -f $_MACKUP_FILE ] && cp $_MACKUP_FILE $HOME/.mackup.cfg