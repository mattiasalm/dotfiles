#!/bin/zsh -e

## General UI/UX

# Configure computer name
echo
_CURRENT_NAME=$(scutil --get ComputerName 2>/dev/null || echo "")
read-input $DOTFILES_PATH/.tmp "Computer name" "$_CURRENT_NAME"
_COMPUTERNAME=$(<$DOTFILES_PATH/.tmp)

# Only change computer name if it's different from current
if [ "$_COMPUTERNAME" != "$_CURRENT_NAME" ]; then
    # Generate hostname from computer name (lowercase, spaces to hyphens)
    _LOCALHOSTNAME=$(echo "$_COMPUTERNAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

    color-print blue "Setting computer name: $_COMPUTERNAME"
    color-print blue "Setting hostname: $_LOCALHOSTNAME"

    sudo scutil --set ComputerName "$_COMPUTERNAME"
    sudo scutil --set HostName "$_LOCALHOSTNAME"
    sudo scutil --set LocalHostName "$_LOCALHOSTNAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$_LOCALHOSTNAME"
    color-print green "Computer name updated successfully"
else
    color-print yellow "Computer name unchanged ($_CURRENT_NAME)"
fi

# Configure system language
echo
color-print cyan "Select system language:"
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
        color-print yellow "Keeping current system language"
        _LOCALE=$(defaults read NSGlobalDomain AppleLocale 2>/dev/null || echo "en_US")
        # Replace the currency of the locale, or add it if the locale has none
        case $_LOCALE in
            *currency=*) _LOCALE=$(echo "$_LOCALE" | sed 's/currency=[^;]*/currency=SEK/') ;;
            *@*) _LOCALE="$_LOCALE;currency=SEK" ;;
            *) _LOCALE="$_LOCALE@currency=SEK" ;;
        esac
        ;;
esac

if [ "$_LANGUAGE_OPTION" = 0 ] || [ "$_LANGUAGE_OPTION" = 1 ]; then
    color-print blue "Setting system language: $_PRIMARY_LANG"
    color-print blue "Setting locale: $_LOCALE"
    
    defaults write NSGlobalDomain AppleLanguages -array "$_PRIMARY_LANG" "en"
    defaults write NSGlobalDomain AppleLocale -string "$_LOCALE"
    color-print green "System language configured successfully"
else
    # Still set SEK currency for "Other" option
    defaults write NSGlobalDomain AppleLocale -string "$_LOCALE"
    color-print green "Currency settings updated to SEK"
fi
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone (see `sudo systemsetup -listtimezones` for other values)
sudo systemsetup -settimezone Europe/Stockholm &>/dev/null

# Disable photos from autostarting
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Disable audio feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 0

# Disable the sound effects on boot
sudo nvram StartupMute=%01

# Disable computer sleep
# sudo systemsetup -setsleep Never > /dev/null

# Menu bar: hide battery percentage
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool false

# Menu bar: always show the date in the clock
defaults write com.apple.menuextra.clock ShowDate -int 1

# Use dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

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
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Restart automatically if the computer freezes
# sudo systemsetup -setrestartfreeze on

# Disable Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Hide Siri menu icon
defaults write com.apple.Siri StatusMenuVisible -bool false

# Show network icon in menu bar
defaults write com.apple.controlcenter "NSStatusItem VisibleCC WiFi" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist WiFi -int 18

# Show bluetooth icon in menu bar
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Bluetooth" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18

# Show sound icon in menu bar
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Sound" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Sound -int 18