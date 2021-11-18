#!/bin/zsh -e

# Dock          

# Hide indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool false

# Show only open apps
defaults write com.apple.dock static-only -bool true

# Set icon size
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock tilesize -int 64

# Turn off magnification
defaults write com.apple.dock magnification -bool false

# Disable Launchpad gesture
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.1
defaults write com.apple.dock autohide-delay -float 0.03
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# No bouncing icons
defaults write com.apple.dock no-bouncing -bool true

# Disable menu bar transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Disable run single app at once
defaults write com.apple.dock single-app -bool false

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
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false