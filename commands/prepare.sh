#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

echo
color-print blue "Checking macOS updates..."
_UPDATES_AVAILABLE=$(softwareupdate -l 2>&1)
if echo "$_UPDATES_AVAILABLE" | grep -q "No new software available"; then
    color-print green "macOS up to date"
else
    color-print blue "Software updates available:"
    echo "$_UPDATES_AVAILABLE" | grep "Title:"
    
    echo
    color-print cyan "Select update option:"
    select-option $DOTFILES_PATH/.tmp "Skip updates" "Install recommended" "Install all"
    _SELECTED_OPTION=$(<$DOTFILES_PATH/.tmp)
    
    case $_SELECTED_OPTION in
        1)
            color-print blue "Installing recommended updates..."
            sudo softwareupdate --install --recommended
            color-print green "Recommended updates installed successfully"
            ;;
        2) 
            color-print blue "Installing all available updates..."
            sudo softwareupdate --install --all
            color-print green "All updates installed successfully"
            ;;
        *)
            color-print yellow "Updates skipped by user"
            ;;
    esac
fi
