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

echo
color-print blue "Checking Homebrew packages..."
if is-available brew; then
    # Check for outdated packages first
    _OUTDATED=$(brew outdated --quiet | wc -l | tr -d ' ')
    if [ "$_OUTDATED" -gt 0 ]; then
        color-print blue "$_OUTDATED packages available for update"
        color-print blue "Updating Homebrew packages..."
        brew update
        brew upgrade
        brew cleanup
        color-print green "Homebrew packages updated successfully"
    else
        color-print green "Homebrew packages up to date"
    fi
else
    color-print red "Error: Homebrew required for package updates"
    return 1
fi

echo
color-print blue "Checking Node.js version..."
if is-available n; then
    # Set N_PREFIX to use Homebrew's Apple Silicon directory
    export N_PREFIX="/opt/homebrew"
    
    _CURRENT_NODE=$(node --version 2>/dev/null || echo "none")
    
    # Get latest LTS version available (add 'v' prefix to match node --version format)
    _LATEST_LTS_RAW=$(n --lts 2>/dev/null || echo "none")
    if [ "$_LATEST_LTS_RAW" != "none" ]; then
        _LATEST_LTS="v$_LATEST_LTS_RAW"
    else
        _LATEST_LTS="none"
    fi
    
    if [ "$_CURRENT_NODE" = "none" ]; then
        color-print blue "Installing Node.js LTS..."
        n lts
        _NEW_NODE=$(node --version 2>/dev/null || echo "none")
        color-print green "Node.js installed: $_NEW_NODE"
    elif [ "$_CURRENT_NODE" != "$_LATEST_LTS" ]; then
        color-print blue "Updating Node.js: $_CURRENT_NODE → $_LATEST_LTS"
        n lts
        _NEW_NODE=$(node --version 2>/dev/null || echo "none")
        color-print green "Node.js updated: $_CURRENT_NODE → $_NEW_NODE"
    else
        color-print green "Node.js up to date ($_CURRENT_NODE)"
    fi
else
    color-print red "Error: Node version manager required for Node.js updates"
    return 1
fi