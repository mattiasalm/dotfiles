#!/usr/bin/env bash

printHeading "Hyper plugins"
if hash hyper 2>/dev/null; then
    printInstalling "hypercwd"
    if hyper i hypercwd &>/dev/null; then 
        printNoteSuccess "Done"
    else
        printNoteError "Failed"
    fi

    
    printInstalling "hyperocean"
    if hyper i hyperocean &>/dev/null; then 
        printNoteSuccess "Done"
    else
        printNoteError "Failed"
    fi

    printInstalling "hyper-highlight-active-pane"
    if hyper i hyper-highlight-active-pane &>/dev/null; then 
        printNoteSuccess "Done"
    else
        printNoteError "Failed"
    fi

else
    printError "Hyper is missing"
fi

printHeading "Hyper styling"
if [ -e "$HOME/.hyper.js" ]; then

    printInstalling "Font size"
    sed -i "" "s/fontSize.*,/fontSize: 16,/g" $HOME/.hyper.js
    printNoteSuccess "Done"

    printInstalling "Font family: Hack Nerd Font"
    sed -i "" "s/fontFamily.*,/fontFamily: \'\"Hack Nerd Font\"\, Menlo\, monospace\',/g" $HOME/.hyper.js
    printNoteSuccess "Done"

else
    printError "Hyper is missing"
fi