#!/usr/bin/env bash

set -euo pipefail

# Exit immediately if Proton Pass CLI is installed and authenticated.
if command -v pass-cli >/dev/null 2>&1 &&
  pass-cli info >/dev/null 2>&1; then
  exit 0
fi

# Install Proton Pass CLI if necessary.
if ! command -v pass-cli >/dev/null 2>&1; then
  if ! command -v omarchy >/dev/null 2>&1; then
    printf 'Error: omarchy is required to install Proton Pass CLI.\n' >&2
    exit 1
  fi

  printf 'Installing Proton Pass CLI...\n'
  if ! omarchy pkg add proton-pass-cli-bin; then
    printf 'Error: Proton Pass CLI installation command failed.\n' >&2
    exit 1
  fi
  hash -r
fi

# Verify installation.
if ! command -v pass-cli >/dev/null 2>&1; then
  printf 'Error: Proton Pass CLI installation failed.\n' >&2
  exit 1
fi

# Authenticate if necessary.
if ! pass-cli info >/dev/null 2>&1; then
  if [[ ! -t 0 ]]; then
    printf 'Error: Proton Pass authentication requires an interactive terminal.\n' >&2
    exit 1
  fi

  printf '\nProton Pass authentication is required.\n\n'
  pass-cli login
fi

# Verify authentication.
if ! pass-cli info >/dev/null 2>&1; then
  printf 'Error: Proton Pass authentication failed.\n' >&2
  exit 1
fi
