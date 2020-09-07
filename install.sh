#!/usr/bin/env bash

# Script runtime variables
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Script aliases
# Options prompt - returns result to $_RESULT
alias optionsPrompt="source $DIR/util/options-prompt.sh"

# Load utils
source "$DIR/util/formatting.sh"
source "$DIR/util/functions.sh"

# Quit system prefs
osascript -e 'tell application "System Preferences" to quit'

# Prompt what to install
# Options and script paths should be set in pairs
declare -a ARRAY_PAIR_LEFT=()
declare -a ARRAY_PAIR_RIGHT=()

# TOOLS & APPS
ARRAY_PAIR_LEFT+="Install Homebrew"
ARRAY_PAIR_RIGHT+="scripts/tools/install-homebrew.sh"

ARRAY_PAIR_LEFT+="Install Homebrew packages"
ARRAY_PAIR_RIGHT+="scripts/tools/install-brewfile.sh"

ARRAY_PAIR_LEFT+="Install Mac App Store CLI"
ARRAY_PAIR_RIGHT+="scripts/tools/install-mas.sh"

ARRAY_PAIR_LEFT+="Install Mac App Store apps"
ARRAY_PAIR_RIGHT+="scripts/tools/install-mas-apps.sh"

ARRAY_PAIR_LEFT+="Install Zsh utils"
ARRAY_PAIR_RIGHT+="scripts/tools/install-zsh.sh"

ARRAY_PAIR_LEFT+="Install Node.js and NPM"
ARRAY_PAIR_RIGHT+="scripts/tools/install-npm.sh"

ARRAY_PAIR_LEFT+="Install Hyper styling"
ARRAY_PAIR_RIGHT+="scripts/tools/install-hyper-styling.sh"

# # SETTINGS
ARRAY_PAIR_LEFT+="Add MacOS app settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/app-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS boot and restart settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/boot-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS Dock settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/dock-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS file settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/file-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS Finder settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/finder-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS print settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/print-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS privacy and energy settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/privacy-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS Safari settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/safari-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS track and type settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/track-type-settings.sh"

ARRAY_PAIR_LEFT+="Add MacOS updating settings"
ARRAY_PAIR_RIGHT+="scripts/macos-settings/updating-settings.sh"

# Get prompt
optionsPrompt "What should be installed?" $ARRAY_PAIR_LEFT

# Demand sudo password
source "$DIR/scripts/demand-sudo.sh"

# Do installations sequentally
_COUNT=1
_RESULT_LEN="${#_RESULT}"
while (( _COUNT <= _RESULT_LEN )); do
    local _SCRIPT=$ARRAY_PAIR_RIGHT[$_COUNT]
    local _RE=$_RESULT[$_COUNT]
    (( _RE == 1 )) && source "${DIR}/${_SCRIPT}"
    (( _COUNT++ ))
done

