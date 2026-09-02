#!/usr/bin/env bash

# Install cronie
omarchy pkg add cronie

# Enable and start the cronie service
sudo systemctl enable --now cronie.service
