#!/usr/bin/env bash

# Set the default editor to neovim if and only if neovim is installed and set manpager as neovim
if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export MANPAGER="nvim +Man!"
fi

# Set default path for tries
export TRY_PATH=~/code/sketches

# Manpager Syntax Highlighting (WIP)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
