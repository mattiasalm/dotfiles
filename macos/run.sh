#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Prompt for sudo up front
ask-sudo

# Close System Preferences
osascript -e 'tell application "System Preferences" to quit'

# Apply settings for each settings file
color-print yellow "Applying settings for:"
for _SETTINGS_FILE in "${DOTFILES_PATH}"/macos/settings/*.sh; do
	color-print yellow "  - $(basename $_SETTINGS_FILE .sh)"
	. "${_SETTINGS_FILE}"
done

# Restart affected apps
for app in "Address Book" "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "iCal"; do
	killall "${app}" &> /dev/null
done

