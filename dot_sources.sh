#!/usr/bin/env bash

# ble.sh (must be loaded before atuin init)
source /usr/share/blesh/ble.sh 2>/dev/null || true

# Atuin
[ -f ~/.atuin/bin/env ] && source ~/.atuin/bin/env

# FZF Integration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Custom Bash Commands
[ -f ~/.custom_bash_commands.sh ] && source ~/.custom_bash_commands.sh

# Autocompletions
[ -f ~/.autocompletions.sh ] && source ~/.autocompletions.sh

# Exports
[ -f ~/.exports.sh ] && source ~/.exports.sh
