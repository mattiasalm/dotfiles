#!/usr/bin/env bash

printHeading "Track and type settings"

osascript -e 'tell application "System Preferences" to quit'

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write 'Apple Global Domain' com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true
printTask "Enable tap to click behaviour" $?

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1
printTask "Configure keyboard repeat" $?

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
printTask "Disable automatic capitalization as it’s annoying when typing code" $?

defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
printTask "Disable smart dashes as they’re annoying when typing code" $?

defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
printTask "Disable automatic period substitution as it’s annoying when typing code" $?

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
printTask "Disable smart quotes as they’re annoying when typing code" $?

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
printTask "Disable auto-correct" $?

defaults write com.apple.BezelServices kDimTime -int 300
printTask "Turn off keyboard illumination when computer is not used for 5 minutes" $?
