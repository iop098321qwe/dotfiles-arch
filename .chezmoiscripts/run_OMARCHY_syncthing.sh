#!/usr/bin/env bash

# Install syncthing
omarchy pkg add syncthing

# Enable and start the syncthing service
systemctl --user enable --now syncthing.service
