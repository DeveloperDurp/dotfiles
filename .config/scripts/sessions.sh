#!/bin/bash

action=${1:-}

[ -z "$action" ] && echo "Please enter an action" && return 1

if [[ $action == "new" ]]; then
  dir=$(find $HOME/Documents/gitlab -mindepth 2 -maxdepth 2 -type d | awk -F/ '{print $(NF-1)"/"$NF " " $0}' | fzf --no-preview --reverse --header "New Session" --with-nth=1 | awk '{print $2}')
  [ -z "$dir" ] && return 1

  name=$(basename "$dir")
  if [[ $name == .* ]]; then
    name=${name#.}
  fi

  tmux has-session -t ${name} >/dev/null && {
    tmux switch-client -t ${name}
    return
  }
  tmux new-session -d -s "$name" -c "$dir"
  tmux rename-window -t "$name" "nvim"
  tmux new-window -t "$name" -n terminal -c "$dir"
  sleep 1
  tmux send-keys -t "$name:1" 'set-env; nvim' C-m
  tmux select-window -t "$name:1"
  tmux switch-client -t "$name"
fi

if [[ $action == "switch" ]]; then

  tmux list-sessions -F '#{?session_attached,,#{session_name}}' |
    sed '/^popup/d' |
    sed '/^$/d' |
    fzf --reverse --header 'Switch Session' --preview 'tmux capture-pane -pt {}' \
      --bind 'enter:execute(tmux switch-client -t {})+accept'

fi

if [[ $action == "delete" ]]; then

  tmux list-sessions -F '#{?session_attached,,#{session_name}}' |
    sed '/^popup/d' |
    sed '/^$/d' |
    fzf --reverse --header 'Delete Session' --preview 'tmux capture-pane -pt {}' \
      --bind 'enter:execute(tmux kill-session -t {})+accept'

fi

if [[ $action == "window" ]]; then

  window=$(tmux list-windows -F '#{window_index} #{window_name}' |
    sed '/^$/d' |
    fzf --reverse --header 'Switch Window' --no-preview |
    cut -d ' ' -f 1)

  [ -z "$window" ] && return 1

  tmux select-window -t $window

fi
