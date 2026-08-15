#!/usr/bin/env bash

# Install cronie
omarchy pkg add cronie
sudo systemctl enable --now cronie.service
