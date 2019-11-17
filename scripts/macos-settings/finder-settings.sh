#!/usr/bin/env bash

printHeading "Finder settings"

defaults write com.apple.finder AppleShowAllFiles YES

printTask "Show hidden files" $?
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
printTask "Always show all file extensions" $?

defaults write com.apple.screencapture location -string "${HOME}/Downloads"
printTask "Save screenshots to Downloads folder" $?

defaults write com.apple.finder QuitMenuItem -bool true
printTask "Allow quitting via ⌘ + q" $?

defaults write com.apple.finder DisableAllAnimations -bool true
printTask "Disable window animations" $?

defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"
printTask "Set Downloads as the default location for new Finder windows" $?

defaults write com.apple.finder ShowStatusBar -bool false
printTask "Disable status bar" $?

defaults write com.apple.finder ShowPathbar -bool false
printTask "Disable path bar" $?

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
printTask "Display full POSIX path as Finder window title" $?

defaults write com.apple.finder _FXSortFoldersFirst -bool true
printTask "Keep folders on top when sorting by name" $?

defaults write -g QLPanelAnimationDuration -float 0
printTask "Disable quick look animation" $?

# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# printTask "When performing a search, search the current folder by default" $?

# Four-letter codes for view modes: icnv, clmv, Flwv, Nlsv
defaults write com.apple.finder FXPreferredViewStyle -string clmv
printTask "Use list view in all Finder windows by default" $?

defaults write com.apple.finder WarnOnEmptyTrash -bool false
printTask "Disable the warning before emptying the Trash" $?

defaults write com.apple.finder SidebarWidth -int 200
printTask "Set sidebar width to 200" $?

defaults write com.apple.finder ShowPreviewPane -bool true
printTask "Show preview pane" $?

defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
printTask "Hide removable media from desktop" $?

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
printTask "Hide external hard drives from desktop" $?

defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
printTask "Hide hard drives from desktop" $?

defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
printTask "Hide mounted server drives from desktop" $?

defaults write com.apple.finder ShowRecentTags -bool false
printTask "Hide tags from sidebar" $?


# Restart Finder
killall Finder
