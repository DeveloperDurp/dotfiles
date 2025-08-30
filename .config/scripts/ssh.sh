#!/bin/bash

yubikeys=$(ykman list)

# Check if any YubiKeys were found
if [[ -z "$yubikeys" ]]; then
  echo "No YubiKeys found."
  exit 1
fi

selected=$(echo "$yubikeys" | wofi --dmenu -i)

# Check if the user made a selection
if [[ -z "$selected" ]]; then
  echo "No selection made."
  exit 1
fi

YUBIKEY_SERIAL=$(echo "$selected" | awk '{print $NF}')

if [ -L "$HOME/.ssh/id_rsa" ]; then
  rm "$HOME/.ssh/id_rsa"
fi

# Create the symbolic link
ln -s "$HOME/.config/yubikey/id_$YUBIKEY_SERIAL" $HOME/.ssh/id_rsa
chmod 600 "$HOME/.ssh/id_rsa"

if [ -n "$SSH_AGENT_PID" ]; then
  kill "$SSH_AGENT_PID"
fi

# Start a new ssh-agent
eval $(ssh-agent -s)

# Update tmux sessions
tmux ls 2>/dev/null | cut -d ':' -f1 | while read -r session_name; do
  tmux setenv -t "$session_name" SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
  tmux setenv -t "$session_name" SSH_AGENT_PID "$SSH_AGENT_PID"
  tmux refresh-client -t "$session_name"
  echo "Updated tmux session: $session_name"
done

# Check if the symbolic link was created successfully
if [ -L "$HOME/.ssh/id_rsa" ]; then
  echo "Symbolic link created successfully at $target"
else
  echo "Failed to create symbolic link at $target"
  exit 1
fi

notify-send "SSH Key has been updated for $(echo $selected | awk '{split($0,a,"("); print a[1]}')"
exit 0
