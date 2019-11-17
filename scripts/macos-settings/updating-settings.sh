#!/usr/bin/env bash

printHeading "Updating settings"

osascript -e 'tell application "System Preferences" to quit'

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
printTask "Enable the automatic update check" $?

defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
printTask "Check for software updates daily, not just once per week" $?

defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
printTask "Download newly available updates in background" $?

defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
printTask "Install System data files & security updates" $?

defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 0
printTask "Automatically download apps purchased on other Macs" $?

defaults write com.apple.commerce AutoUpdate -bool true
printTask "Turn on app auto-update" $?

defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
printTask "Allow the App Store to reboot machine on macOS updates" $?

