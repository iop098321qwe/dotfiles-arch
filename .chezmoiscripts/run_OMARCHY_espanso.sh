#!/usr/bin/env bash

# Install Espanso
omarchy pkg aur add espanso-wayland

# Ensure the Espanso service is registered.
if ! systemctl --user cat espanso.service &> /dev/null; then
  echo "Registering Espanso service..."
  espanso service register
fi

# Ensure Espanso is running.
systemctl --user is-active --quiet espanso.service || espanso start
