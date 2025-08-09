#!/bin/bash

# Path to your YubiKey identifiers
YUBIKEY_5C_IDENTIFIER="28854922"
YUBIKEY_NANO_IDENTIFIER="33923085"
YUBIKEY_SERIAL=$(ykman list | sed -n 's/.*Serial: //p')

# Check for connected YubiKeys
if echo "$YUBIKEY_SERIAL" | grep -q "$YUBIKEY_5C_IDENTIFIER"; then
  export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_sk'
elif echo "$YUBIKEY_SERIAL" | grep -q "$YUBIKEY_NANO_IDENTIFIER"; then
  export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_sk_nano'
else
  echo "No YubiKey detected!"
  exit 1
fi

# Now run the Git command passed to the script
git "$@"
