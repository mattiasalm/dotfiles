#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Run software update (only if needed)
color-print yellow "Checking for macOS updates"
_UPDATE_COUNT=$(softwareupdate -l 2>&1 | grep -c "restart" || true)
if [ "$_UPDATE_COUNT" -gt 0 ]; then
    color-print cyan "Found $_UPDATE_COUNT updates requiring restart"
    select-option $DOTFILES_PATH/.tmp "Skip updates" "Install updates"
    _SELECTED_OPTION=$(<$DOTFILES_PATH/.tmp)
    if (( _SELECTED_OPTION == 1 )); then
        . $(dirname $0)/prepare.sh
    fi
else
    color-print green "macOS is up to date"
fi

# Run Homebrew update
color-print yellow "Updating Homebrew packages"
if is-available brew; then
    # Check for outdated packages first
    _OUTDATED=$(brew outdated --quiet | wc -l | tr -d ' ')
    if [ "$_OUTDATED" -gt 0 ]; then
        color-print cyan "Found $_OUTDATED outdated packages"
        brew update
        brew upgrade
        brew cleanup
        color-print green "Homebrew packages updated"
    else
        color-print green "All Homebrew packages are up to date"
    fi
else
    color-print red "Homebrew missing, needed for update"
fi

# Update Node.js
color-print yellow "Updating Node.js"
if is-available n; then
    _CURRENT_NODE=$(node --version 2>/dev/null || echo "none")
    n lts
    _NEW_NODE=$(node --version 2>/dev/null || echo "none")
    if [ "$_CURRENT_NODE" != "$_NEW_NODE" ]; then
        color-print green "Node.js updated from $_CURRENT_NODE to $_NEW_NODE"
    else
        color-print green "Node.js is already up to date ($_CURRENT_NODE)"
    fi
else
    color-print red "n is missing, needed for npm and Node update"
fi