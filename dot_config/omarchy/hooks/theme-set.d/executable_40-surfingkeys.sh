#!/usr/bin/env bash
set -euo pipefail

# Omarchy invokes this after staging the new current theme.
node "$HOME/.config/surfingkeys/omarchy-theme.cjs" publish
