#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Check for software updates
color-print yellow "Checking for macOS software updates"
_UPDATES_AVAILABLE=$(softwareupdate -l 2>&1)
if echo "$_UPDATES_AVAILABLE" | grep -q "No new software available"; then
    color-print green "macOS is up to date"
else
    color-print cyan "Software updates available:"
    echo "$_UPDATES_AVAILABLE" | grep "Title:"
    echo
    select-option $DOTFILES_PATH/.tmp "Skip updates" "Install recommended" "Install all"
    _SELECTED_OPTION=$(<$DOTFILES_PATH/.tmp)
    
    case $_SELECTED_OPTION in
        1)
            color-print yellow "Installing recommended updates only"
            sudo softwareupdate --install --recommended
            ;;
        2) 
            color-print yellow "Installing all available updates"
            sudo softwareupdate --install --all
            ;;
        *)
            color-print yellow "Skipping software updates"
            ;;
    esac
fi

# Install Rosetta 2 for Intel app compatibility
color-print yellow "Checking Rosetta 2 installation"
if /usr/bin/pgrep -q oahd; then
    color-print green "Rosetta 2 already installed"
else
    color-print cyan "Installing Rosetta 2 for Intel app compatibility"
    softwareupdate --install-rosetta --agree-to-license
    if [ $? -eq 0 ]; then
        color-print green "Rosetta 2 installed successfully"
    else
        color-print red "Failed to install Rosetta 2"
    fi
fi

# Install Xcode Command Line Tools
color-print yellow "Checking Xcode Command Line Tools"
if xcode-select -p &>/dev/null; then
    color-print green "Xcode Command Line Tools already installed"
else
    color-print cyan "Installing Xcode Command Line Tools (required for development)"
    xcode-select --install
    
    # Wait for installation to complete
    color-print yellow "Waiting for Xcode Command Line Tools installation..."
    until xcode-select -p &>/dev/null; do
        sleep 5
    done
    color-print green "Xcode Command Line Tools installed successfully"
fi
