#!/bin/zsh -e

## Calendar               

# Show week numbers
defaults write com.apple.iCal "Show Week Numbers" -bool true

# Week starts on monday
defaults write com.apple.iCal "first day of week" -int 2