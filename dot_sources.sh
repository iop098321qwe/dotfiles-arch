#!/usr/bin/env bash

# ble.sh is loaded at the end of ~/.bashrc, after Readline integrations.

# FZF Integration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Custom Bash Commands
[ -f ~/.custom_bash_commands.sh ] && source ~/.custom_bash_commands.sh

# # Autocompletions
# [ -f ~/.autocompletions.sh ] && source ~/.autocompletions.sh

# Exports
[ -f ~/.exports.sh ] && source ~/.exports.sh
