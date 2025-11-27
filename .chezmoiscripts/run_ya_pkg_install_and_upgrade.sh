#!/bin/sh

# Upgrade ya packages
# if yay -Qs yazi &> /dev/null; then
#   ya pkg install && ya pkg upgrade
# else
#   echo "yazi is not installed."
# fi

if gum confirm "Would you like to update yazi packages?": then
  if yay -Qs yazi &> /dev/null; then
    ya pkg install && ya pkg upgrade
  else
    echo "yazi is not installed."
  fi
else
  echo "Skipping yazi packages update."
fi
