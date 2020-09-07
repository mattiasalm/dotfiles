#!/usr/bin/env bash

printHeading "Zsh utils"

printInstalling "Set Zsh to default shell"
if chsh -s /bin/zsh &>/dev/null; then
  printNoteSuccess "Done"
else 
  printNoteError "Failed"
fi

printInstalling "Powerlevel10k Zsh theme"
if [ -e "$HOME/powerlevel10k" ]; then
  printNoteSuccess "Already installed"
else 
  if git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &>/dev/null; then
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
    printNoteSuccess "Done"
  else 
    printNoteError "Failed"
  fi
fi