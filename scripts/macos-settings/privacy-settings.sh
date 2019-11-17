#!/usr/bin/env bash

printHeading "Privacy and energy settings"

osascript -e 'tell application "System Preferences" to quit'

defaults -currentHost write com.apple.screensaver idleTime -int 300
printTask "Set screensaver delay - 5 min" $?

sudo pmset -a hibernatemode 0
printTask "Disable hibernation (speeds up entering sleep mode)" $?

sudo systemsetup -setcomputersleep Off > /dev/null
printTask "Never go into computer sleep mode" $?

# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null
# printTask "Disable Notification Center and remove the menu bar icon" $?

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
printTask "Require password immediately after sleep or screen saver begins" $?
