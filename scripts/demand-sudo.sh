#!/usr/bin/env bash

printHeading "Sudo password"
printInstalling "Prompt for password"
if sudo --validate; then
    # Keep-alive
    while true; do sudo --non-interactive true; \
        sleep 10; kill -0 "$$" || exit; done 2>/dev/null &
    tput cuu1
    tput el
    printNoteSuccess "Sudo password updated"
else
    printNoteError "Sudo password update failed"
    exit 1
fi