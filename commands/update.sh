#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

echo
color-print blue "Checking macOS updates..."
_UPDATE_COUNT=$(softwareupdate -l 2>&1 | grep -c "restart" || true)
if [ "$_UPDATE_COUNT" -gt 0 ]; then
    color-print blue "$_UPDATE_COUNT updates available (restart required)"
    color-print cyan "Install macOS updates:"
    select-option $DOTFILES_PATH/.tmp "Skip updates" "Install updates"
    _SELECTED_OPTION=$(<$DOTFILES_PATH/.tmp)
    if (( _SELECTED_OPTION == 1 )); then
        . $(dirname $0)/prepare.sh
    else
        color-print yellow "macOS updates skipped by user"
    fi
else
    color-print green "macOS up to date"
fi

. $DOTFILES_PATH/commands/sub-commands/homebrew.sh

. $DOTFILES_PATH/commands/sub-commands/node.sh
