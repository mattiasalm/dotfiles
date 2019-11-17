#!/usr/bin/env bash

# Duplicate of official installation script with proper exit
installOhMyZsh() {
  set -e

  if ! command -v zsh >/dev/null 2>&1; then
    exit 1
  fi

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ -d "$ZSH" ]; then
    exit 1
  fi

  umask g-w,o-w
  
  command -v git >/dev/null 2>&1 || {
    exit 1
  }
  env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" || {
    exit 1
  }
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
  fi

  cp "$ZSH"/templates/zshrc.zsh-template ~/.zshrc
  sed "/^export ZSH=/ c\\
  export ZSH=\"$ZSH\"
  " ~/.zshrc > ~/.zshrc-omztemp
  mv -f ~/.zshrc-omztemp ~/.zshrc

  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(basename "$SHELL")
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    if hash chsh >/dev/null 2>&1; then
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    fi
  fi
}

printHeading "oh-my-zsh and styling"

# oh-my-zsh
printInstalling "oh-my-zsh"
if test -d "$HOME/.oh-my-zsh"; then
    printNoteSuccess "Already installed"
else 
    if installOhMyZsh &> /dev/null; then
        printNoteSuccess "Successfully installed"
    else 
        printNoteError "Installation failed"
        exit 1
    fi
fi

# Add zsh-syntax-highlighting
printInstalling "zsh-syntax-highlighting"
local DOTFILES_RESOURCES="${HOME}/.dotfiles-resources"
local ZSHSHL_DESTINATION=$DOTFILES_RESOURCES/.zsh-syntax-highlighting
local ZSHSHL="source ${ZSHSHL_DESTINATION}/zsh-syntax-highlighting.zsh"
if test -d $ZSHSHL_DESTINATION; then
    printNoteSuccess "Already added"
else 
    local url=https://github.com/zsh-users/zsh-syntax-highlighting.git
    if git clone "$url" $ZSHSHL_DESTINATION; then
        printNoteSuccess "Successfully added"
    else
        printNoteError "Failed to add"
        exit 1
    fi
fi
if ! grep -Fxq "$ZSHSHL" $HOME/.zshrc; then
    if echo $ZSHSHL>>$HOME/.zshrc; then
        printNoteSuccess "Init of zsh-syntax-highlighting added to .zshrc"
    fi
fi



# TODO: Add https://github.com/romkatv/powerlevel10k#manual

# TODO: Add aliases and other useful stuff