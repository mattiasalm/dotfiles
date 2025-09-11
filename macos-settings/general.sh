#!/bin/zsh -e

## General UI/UX

# Set computer name
read-input $DOTFILES_PATH/.tmp "Enter computer name"
_COMPUTERNAME=$(<$DOTFILES_PATH/.tmp)

# Generate hostname from computer name (lowercase, spaces to hyphens)
_LOCALHOSTNAME=$(echo "$_COMPUTERNAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

color-print yellow "Setting computer name to: $_COMPUTERNAME"
color-print yellow "Setting hostname to: $_LOCALHOSTNAME"

sudo scutil --set ComputerName "$_COMPUTERNAME"
sudo scutil --set HostName "$_COMPUTERNAME"
sudo scutil --set LocalHostName "$_LOCALHOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$_LOCALHOSTNAME"

# Set language and text formats
color-print cyan "Select your preferred language:"
select-option $DOTFILES_PATH/.tmp "Swedish (sv)" "English (en)" "Other (keep current)"
_LANGUAGE_OPTION=$(<$DOTFILES_PATH/.tmp)

case $_LANGUAGE_OPTION in
    0)
        # Swedish
        _PRIMARY_LANG="sv"
        _LOCALE="sv_SE@currency=SEK"
        ;;
    1) 
        # English
        _PRIMARY_LANG="en"
        _LOCALE="en_US@currency=SEK"
        ;;
    *)
        # Other - keep current system defaults
        color-print yellow "Keeping current system language settings"
        _PRIMARY_LANG=$(defaults read NSGlobalDomain AppleLanguages | head -1 | sed 's/[^a-z]//g' || echo "en")
        _LOCALE=$(defaults read NSGlobalDomain AppleLocale 2>/dev/null | sed 's/@currency=.*/@currency=SEK/' || echo "en_US@currency=SEK")
        ;;
esac

if [ "$_LANGUAGE_OPTION" -ne 2 ]; then
    color-print yellow "Setting language to: $_PRIMARY_LANG"
    color-print yellow "Setting locale to: $_LOCALE"
    
    defaults write NSGlobalDomain AppleLanguages -array "$_PRIMARY_LANG" "en"
    defaults write NSGlobalDomain AppleLocale -string "$_LOCALE"
else
    # Still set SEK currency for "Other" option
    defaults write NSGlobalDomain AppleLocale -string "$_LOCALE"
fi
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone (see `sudo systemsetup -listtimezones` for other values)
sudo systemsetup -settimezone Europe/Stockholm &>/dev/null

# Disable photos from autostarting
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Prevent iTunes from autostarting
defaults write com.apple.iTunes dontAutomaticallySyncIPods -int 1

# Disable audio feedback when volume is changed
defaults write com.apple.sound.beep.feedback -bool false

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable computer sleep
# sudo systemsetup -setsleep Never > /dev/null

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Restart automatically if the computer freezes
# sudo systemsetup -setrestartfreeze on

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable Siri
defaults write com.apple.assistant.support.plist "Assistant Enabled" -bool false

# Hide Siri menu icon
defaults write com.apple.Siri StatusMenuVisible -bool false

# Show network icon in menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist WiFi -int 18

# Show bluetooth icon in menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18

# Show sound icon in menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Sound -int 18