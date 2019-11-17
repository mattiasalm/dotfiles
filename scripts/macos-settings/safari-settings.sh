#!/usr/bin/env bash

printHeading "Safari settings"

defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25
printTask "Disable Safari rendering delay" $?

defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
printTask "Enable the Develop menu and the Web Inspector in Safari" $?

defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
printTask "Warn about fraudulent websites" $?

defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
printTask "Disable plug-ins" $?

defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
printTask "Disable Java" $?

defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false
printTask "Block pop-up windows" $?

defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
printTask "Enable 'Do Not Track'" $?

# Restart Safari
killall Safari &> /dev/null