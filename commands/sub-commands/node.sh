#!/bin/zsh -e

# Node.js version check and management
# This script handles Node.js installation and updates using the 'n' version manager

echo
color-print blue "Checking Node.js version..."
if is-available n; then

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
