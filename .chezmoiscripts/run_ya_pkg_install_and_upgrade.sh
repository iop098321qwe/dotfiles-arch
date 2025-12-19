#!/usr/bin/env bash

update=false
# Upgrade ya packages

yainstall() {
  ya pkg install
  ya pkg upgrade
}

checkyainstall() {
  if yay -Qs yazi &> /dev/null; then
   yainstall
  else
    echo "yazi is not installed."
  fi
}

if gum confirm "Would you like to update yazi packages?"; then
  update=true
else
  update=false
fi

if [ $update == true ]; then
  checkyainstall
else
  echo "Skipping yazi packages update."
fi
