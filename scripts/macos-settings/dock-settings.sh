#!/usr/bin/env bash

printHeading "Dock settings"

defaults write com.apple.dock static-only -bool true
printTask "Show only open applications in Dock" $?

defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock tilesize -int 64
printTask "Set icon size" $?

defaults write com.apple.dock magnification -bool false
printTask "Disable dock magnification" $?

defaults write com.apple.dock autohide-time-modifier -float 0.2
defaults write com.apple.dock autohide-delay -float 0.05
defaults write com.apple.dock autohide -bool true
printTask "Set autohide time and delay" $?

defaults write com.apple.dock no-bouncing -bool true
printTask "Disable app icon bounce on start" $?

defaults write com.apple.dock show-process-indicators -bool false
printTask "Hide indicator lights for open applications in the Dock" $?

defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
printTask "Disable Launchpad gesture" $?

defaults write com.apple.dashboard mcx-disabled -bool true
printTask "Disable MacOS Dashboard" $?
defaults write com.apple.dock dashboard-in-overlay -bool true

defaults write com.apple.dock single-app -bool false
printTask "Disable run single app at once" $?

defaults write com.apple.universalaccess reduceTransparency -bool true
printTask "Disable menu bar transparency"

## Hot corners
## Possible values (corner)
##  0: no-op
##  2: Mission Control
##  3: Show application windows
##  4: Desktop
##  5: Start screen saver
##  6: Disable screen saver
##  7: Dashboard
## 10: Put display to sleep
## 11: Launchpad
## 12: Notification Center
## Modifier sets combination key
##  no modifier key is 0
##  Shift is 2^17 or 131072
##  Control is 2^18 or 262144
##  Option is 2^19 or 524288
##  Command is 2^20 or 1048576
## Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
printTask "Hot corner - top left: Nothing" $?
## Top right screen corner → Nothing
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
printTask "Hot corner - top right: Nothing" $?
## Bottom left screen corner → Nothing
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0
printTask "Hot corner - bottom left: Start screen saver" $?
## Bottom right screen corner → Nothing
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0
printTask "Hot corner - bottom left: Nothing" $?


# Restart Dock
killall Dock