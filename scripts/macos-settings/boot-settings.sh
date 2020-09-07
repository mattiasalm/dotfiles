#!/usr/bin/env bash

printHeading "Boot and restart settings"

osascript -e 'tell application "System Preferences" to quit'

sudo nvram SystemAudioVolume=" "
printTask "Disable sound effects on boot" $?

sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true
printTask "Show language menu in the top right corner of the boot screen" $?

defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
printTask "Disable Resume system-wide" $?

# sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "In case of loss, call 555-555-5555."
# printTask "Customized login screen message" $?

sudo systemsetup -setrestartfreeze on
printTask "Restart automatically if the computer freezes" $?


sudo pmset -a autorestart 1
printTask "Auto restart on power loss"