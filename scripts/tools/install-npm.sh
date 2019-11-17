#!/usr/bin/env bash

printHeading "NVM, Node.js and NPM"

# NVM
local NVMDESIREDVERSION="0.34.0"
printInstalling "NVM v${NVMDESIREDVERSION}"
if command -v nvm &> /dev/null; then
    local url=https://raw.githubusercontent.com/creationix/nvm/v$NVMDESIREDVERSION/install.sh
    if sh -c "$(curl -fsSL ${url})" &> /dev/null; then
        printNoteSuccess "nvm successfully installed"
    else
        printNoteError "Installation failed"
        exit 1
    fi
else 
    printNoteSuccess "Already installed"
fi

if test -e $HOME/.zshrc; then
    local _nvm=$(grep -o '^plugins=\(.*\)' $HOME/.zshrc | sed -E 's/plugins=\((.*)\)/\1/g' | grep -o 'nvm')
    if [[ "$_nvm" == "nvm" ]]; then
        printNoteSuccess ".zshrc has already nvm plugin"
    else
        if sed -Ei "" 's/plugins=\((.*)\)/plugins=\(\1 nvm\)/g' $HOME/.zshrc; then
            printNoteSuccess "nvm plugin added in .zshrc"
        else
            printNoteError "Failed to add nvm plugin in .zshrc"
            exit 1
        fi
    fi

    NVM_DIR=$HOME/.nvm
    local NVM_SOURCING="export NVM_DIR=\"$NVM_DIR\"\ntest -e \"$NVM_DIR/bash_completion\" && source \"$NVM_DIR/bash_completion\"\ntest -e \"$NVM_DIR/nvm.sh\" && source \"$NVM_DIR/nvm.sh\""
    if grep -o 'export NVM_DIR=' $HOME/.zshrc &> /dev/null; then
        printNoteSuccess "Sourcing of nvm already added to .zshrc"
    else
        if echo $NVM_SOURCING>>$HOME/.zshrc; then
            printNoteSuccess "Added source of nvm to .zshrc"
        else
            printNoteError "Failed to add source of nvm to .zshrc"
            exit 1
        fi
    fi
    source $NVM_DIR/nvm.sh
else
    printNoteError "No .zshrc found"
    exit 1
fi



# # NodeJS
printInstalling "Node.js"
if command -v node &> /dev/null; then
    printNoteSuccess "Already installed"
else 
    if nvm install --lts &> /dev/null; then
        printNoteSuccess "Node.js LTS installed"
    else
        printNoteError "Installation failed"
        exit 1
    fi
fi

# # NPM
printInstalling "NPM"
if command -v npm &> /dev/null; then
    printNoteSuccess "Already installed"
else 
    if nvm install-latest-npm &> /dev/null; then
        printNoteSuccess "Latest NPM installed"
    else
        printNoteError "Installation failed"
        exit 1
    fi
fi