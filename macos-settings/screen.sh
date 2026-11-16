#!/bin/zsh -e

## Screen           

# Require password immediately after sleep, screen saver or closing the lid (asks for the user password)
if ! sysadminctl -screenLock status 2>&1 | grep -q "immediate"; then
	sysadminctl -screenLock immediate -password -
fi

# Set screen saver delay to 5 min
defaults -currentHost write com.apple.screensaver idleTime -int 300

# Save screenshots to the downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Use medium font smoothing on non-Retina displays
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Turn off screen after 15 minutes (battery)
sudo pmset -b displaysleep 15

# Turn off screen after 15 minutes (charger)
sudo pmset -c displaysleep 15