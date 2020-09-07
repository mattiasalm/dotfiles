#!/usr/bin/env bash

printHeading "Node.js and NPM using N"

if hash n 2>/dev/null; then 

  printInstalling "Node LTS & NPM LTS"
  if sudo n lts &>/dev/null; then
    printNoteSuccess "Done"
  else
    printNoteError "Failed"
  fi
else
  printError "N is missing"
fi
