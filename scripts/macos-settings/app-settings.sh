#!/usr/bin/env bash

printHeading "App settings"

osascript -e 'tell application "System Preferences" to quit'

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
printTask "Disable Photos from autostarting" $?

defaults write com.apple.LaunchServices LSQuarantine -bool false
printTask "Disable the 'Are you sure you want to open this application?' dialog" $?

defaults write com.apple.CrashReporter DialogType -string "none"
printTask "Disable the crash reporter" $?

defaults write com.apple.iTunes dontAutomaticallySyncIPods -int 1
printTask "Prevent iTunes from launching on mount" $?
