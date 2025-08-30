#!/bin/bash

# Variables
YUBIKEY_ID_DIR="$HOME/.config/yubikey"
SSH_ID_RSA="$HOME/.ssh/id_rsa"

# Function to display an error message and exit
error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# Find YubiKeys
yubikeys=$(ykman list)
if [[ -z "$yubikeys" ]]; then
  error_exit "No YubiKeys found."
fi

# Select a YubiKey using wofi
selected=$(echo "$yubikeys" | wofi --dmenu -i)
if [[ -z "$selected" ]]; then
  error_exit "No YubiKey selected."
fi

# Extract the YubiKey serial number
YUBIKEY_SERIAL=$(echo "$selected" | awk '{print $NF}')
if [[ -z "$YUBIKEY_SERIAL" ]]; then
  error_exit "Failed to extract YubiKey serial number."
fi

# Remove existing symbolic link if it exists
if [ -L "$SSH_ID_RSA" ]; then
  rm -f "$SSH_ID_RSA"
  if [ $? -ne 0 ]; then
    error_exit "Failed to remove existing symbolic link."
  fi
fi

# Create the symbolic link
ln -s "$YUBIKEY_ID_DIR/id_$YUBIKEY_SERIAL" "$SSH_ID_RSA"
if [ $? -ne 0 ]; then
  error_exit "Failed to create symbolic link."
fi

# Set correct permissions
chmod 600 "$SSH_ID_RSA"
if [ $? -ne 0 ]; then
  error_exit "Failed to set permissions on symbolic link."
fi

# Stop the current ssh-agent
if [ -n "$SSH_AGENT_PID" ]; then
  ssh-agent -k
  if [ $? -ne 0 ]; then
    echo "Failed to stop existing ssh-agent. Continuing..."
  fi
  unset SSH_AGENT_PID SSH_AUTH_SOCK
fi

# Start a new ssh-agent
eval $(ssh-agent -s)
if [ -z "$SSH_AGENT_PID" ]; then
  error_exit "Failed to start ssh-agent."
fi

# Update tmux sessions if tmux is running
if tmux ls 2>/dev/null; then
  tmux ls 2>/dev/null | cut -d ':' -f1 | while read -r session_name; do
    tmux setenv -t "$session_name" SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
    tmux setenv -t "$session_name" SSH_AGENT_PID "$SSH_AGENT_PID"
    tmux refresh-client -t "$session_name"
    if [ $? -ne 0 ]; then
      echo "Failed to update tmux session: $session_name. Continuing..."
    else
      echo "Updated tmux session: $session_name"
    fi
  done
fi

# Verify symbolic link creation
if [ -L "$SSH_ID_RSA" ]; then
  echo "Symbolic link created successfully at $SSH_ID_RSA"
else
  error_exit "Failed to create symbolic link at $SSH_ID_RSA"
fi

# Extract the YubiKey name for the notification
YUBIKEY_NAME=$(echo "$selected" | awk '{split($0,a,"("); print a[1]}')
notify-send "SSH Key has been updated for $YUBIKEY_NAME"

exit 0
