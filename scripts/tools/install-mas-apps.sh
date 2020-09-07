#!/usr/bin/env bash

clearLines() {
    local _LEN=$1
    local _COUNT=1
    while (( _COUNT <= _LEN )); do
        tput cuu1
        tput el
        (( _COUNT++ ))
    done
}

installOnMAS() {
    if mas install $1 &>/dev/null; then
        return 0
    else 
        return 1
    fi
}

declare -a APPS_ID=()
declare -a APPS_NAME=()

# Get the ID of the apps with command 'mas list'
# Gets the list of alls apps installed from MAS
# The name is just for display purposes
# Add app ID and NAME pairs
APPS_ID+="834979136"
APPS_NAME+="Ethernet Status"

APPS_ID+="525912054"
APPS_NAME+="WiFi Signal"

# APPS_ID+="1157906903"
# APPS_NAME+="iOrdning"

# APPS_ID+="409183694"
# APPS_NAME+="Keynote"

# APPS_ID+="409201541"
# APPS_NAME+="Pages"

# APPS_ID+="409203825"
# APPS_NAME+="Numbers"

printHeading "Mac App Store apps"
if hash mas 2>/dev/null; then

    # Check login
    echo -e "\n"
    printMessage "Check that you are signed in in Mac App Store and then press [ENTER]"
    printMessage "Opening Mac App Store..."
    sleep 2
    open -a "App Store"
    printMessage "Waiting for [ENTER]..."
    source "$DIR/util/wait-for-enter.sh"
    clearLines 5

    # Do installations
    _APP_COUNT=1
    _APPS_LEN="${#APPS_ID}"
    while (( _APP_COUNT <= _APPS_LEN )); do
        local _ID=$APPS_ID[$_APP_COUNT]
        local _NAME=$APPS_NAME[$_APP_COUNT]
        
        printInstalling "Installing ${_NAME}"
        if installOnMAS $_ID; then
            printNoteSuccess "Done"
        else
            printNoteError "Failed"
        fi
        (( _APP_COUNT++ ))
    done

    # Update all installed apps
    printInstalling "Upgrading already installed apps"
    if mas upgrade &>/dev/null; then
        printNoteSuccess "Successfully upgraded"
    else
        printNoteError "One or more of the upgrades failed"
    fi
else
    printNoteError "Mac App Store CLI missing"
    exit 1
fi
