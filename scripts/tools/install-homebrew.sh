#!/usr/bin/env bash

printHeading "Homebrew & Homebrew Cask"

# Homebrew
printInstalling "Homebrew"
if hash brew 2>/dev/null; then
    printNoteSuccess "Homebrew already installed"
else
    local url=https://raw.githubusercontent.com/Homebrew/install/master/install.sh
    if /bin/bash -c "$(curl -fsSL ${url})"; then
        printNoteSuccess "Done"
    else
        printNoteError "Failed"
        exit 1
    fi
fi
