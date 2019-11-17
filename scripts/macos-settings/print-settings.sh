#!/usr/bin/env bash

printHeading "Print settings"

osascript -e 'tell application "System Preferences" to quit'

defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
printTask "Enable expanded print menu by default" $?

defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
printTask "Automatically quit printer app once the print jobs complete" $?
