#!/usr/bin/env bash

printHeading "Hyper styling"
if [ -e "$HOME/.hyper.js" ]; then

    # Font size
    printInstalling "Font size"
    sed -i "" 's/fontSize.*,/fontSize: 16,/g' $HOME/.hyper.js
    printNoteSuccess "Done"

else
    printError "Hyper is missing"
fi

#TODO: Add https://hyper.is/plugins/hypercwd

#TODO: Add https://hyper.is/plugins/hyperocean

#TODO: Add https://hyper.is/plugins/hyper-highlight-active-pane

#TODO: Add 'Hack Nerd Font' as font in .hyper.js