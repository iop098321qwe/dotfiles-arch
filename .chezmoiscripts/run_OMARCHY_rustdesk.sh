#!/usr/bin/env bash

# Install RustDesk
omarchy pkg aur add rustdesk-bin

# Enable and start the RustDesk service
sudo systemctl enable --now rustdesk.service
