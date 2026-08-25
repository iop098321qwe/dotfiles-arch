#!/usr/bin/env bash

# Install Proton Mail Bridge
omarchy pkg add protonmail-bridge

# Ensure Proton Mail Bridge starts automatically and is currently running.
systemctl --user enable --now protonmail-bridge.service
