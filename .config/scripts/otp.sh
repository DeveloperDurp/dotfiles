#!/bin/bash

YUBIKEY_5C_IDENTIFIER="28854922"
YUBIKEY_NANO_IDENTIFIER="33923085"
YUBIKEY_SERIAL=$(ykman list | sed -n 's/.*Serial: //p')

# Check for connected YubiKeys
if echo "$YUBIKEY_SERIAL" | grep -q "$YUBIKEY_5C_IDENTIFIER"; then
  YUBIKEY_SERIAL=$YUBIKEY_5C_IDENTIFIER
elif echo "$YUBIKEY_SERIAL" | grep -q "$YUBIKEY_NANO_IDENTIFIER"; then
  YUBIKEY_SERIAL=$YUBIKEY_NANO_IDENTIFIER
else
  echo "No YubiKey detected!"
  exit 1
fi

# Prompt for the password using zenity
password=$(zenity --password --title="Password Required" --text="Enter your password:")

# Check if the user pressed Cancel
if [ $? -ne 0 ]; then
  echo "Password dialog was cancelled."
  exit 1
fi

accounts=$(ykman -d $YUBIKEY_SERIAL oath accounts list -p $password | sort -f)

# Create an array to hold the keys
declare -a keys

# Read the input line by line
while IFS= read -r line; do
  # Extract the part before the colon and store it in the array
  key="${line%%:*}"
  keys+=("$key")
done <<<"$accounts"

selection=$(printf "%s\n" "${keys[@]}" | wofi -dmenu -i -p "New Session" --columns 1)

if [[ $selection == "" ]]; then
  echo "Selection dialog was cancelled."
  exit 1
fi

ykman -d $YUBIKEY_SERIAL oath accounts code $selection -p $password | cut -d' ' -f3 | wl-copy

notify-send "copied $selection to Clipboard"
