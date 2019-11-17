#!/usr/bin/env bash

printHeading "Homebrew packages"

BREW_FILE_PATH="${DIR}/scripts/mac.Brewfile"
printInstalling "Installing packages within Brewfile"
if hash brew 2>/dev/null; then
    if brew bundle check --file="$BREW_FILE_PATH" &> /dev/null; then
        printNoteSuccess "Brewfile's dependencies are already satisfied"
    else
        if brew bundle --file="$BREW_FILE_PATH"; then
            printNoteSuccess "Brewfile installation succeeded"
        else
            printNoteError "Brewfile installation failed"
            exit 1
        fi
    fi
else
    printNoteError "Homebrew missing"
    exit 1
fi
