#!/usr/bin/env bash

printHeading "File settings"

osascript -e 'tell application "System Preferences" to quit'

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
printTask "Save to disk (not to iCloud) by default" $?

defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
printTask "Enable expanded save menu by default" $?

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
printTask "Avoid creating .DS_Store files on network or USB volumes" $?

defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
printTask "Enable AirDrop over Ethernet and on unsupported Macs running Lion" $?

chflags nohidden ~/Library
printTask "Show the ~/Library folder" $?

sudo chflags nohidden /Volumes
printTask "Show the /Volumes folder" $?

defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
printTask "Disable disk image verification" $?
