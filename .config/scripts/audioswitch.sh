#!/bin/bash

# Use pactl to get the name and description pairs
output=$(pactl list sinks | grep -E 'Name:|Description:' | sed 's/^ *//')

# Initialize an empty array to store the sink info
declare -A sinks

# Initialize variables
name=""
description=""
i=0

# Loop through the lines of the output
while read -r line; do
  if [[ "$line" =~ ^Name: ]]; then
    name="${line#Name: }" # Extract the name
  elif [[ "$line" =~ ^Description: ]]; then
    description="${line#Description: }" # Extract the description
    # Store the name and description in the associative array
    sinks[$description]="$name" # Store name by description key
    # Increment the index
    ((i++))
  fi
done <<<"$output"

# Create wofi options string
options=$(printf "%s\n" "${!sinks[@]}")

# Run wofi and capture the selected description
selected_description=$(echo "$options" | wofi -dmenu -i -p "Select Audio Source" --columns 1)

# Check if wofi returned a value (user made a selection)
if [ -n "$selected_description" ]; then

  # Get the corresponding name from the sinks array
  selected_name="${sinks[$selected_description]}"

  # Check if we found a name for the selected description
  if [ -n "$selected_name" ]; then
    pactl set-default-sink "$selected_name"
    notify-send "Set audio device to: $selected_description"
    # **********************************************************************
  else
    notify-send "Error: Could not find name for selected description."
  fi
fi
