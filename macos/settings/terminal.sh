#!/bin/zsh -e

## Terminal               

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Appearance
defaults write com.apple.terminal "Default Window Settings" -string "Pro"
defaults write com.apple.terminal "Startup Window Settings" -string "Pro"
defaults write com.apple.Terminal ShowLineMarks -int 0