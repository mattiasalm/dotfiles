#!/usr/bin/env bash

printHeading "Mac App Store CLI"
printInstalling "Installing Mac App Store CLI"
if hash brew 2>/dev/null; then
    if hash mas 2>/dev/null; then
        printNoteSuccess "Mac App Store CLI already installed"
    else
        if brew install mas &> /dev/null; then
            printNoteSuccess "Mac App Store CLI successfully installed"
        else
            printNoteError "Mac App Store CLI installation failed"
            exit 1
        fi
    fi
else
    printNoteError "Homebrew missing"
    exit 1
fi
