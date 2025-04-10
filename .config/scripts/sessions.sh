#!/bin/bash

new() {

  dir=${1:-}

  [ -z "${dir}" ] && dir=$(find $HOME/Documents/gitlab -mindepth 2 -maxdepth 2 -type d | awk -F/ '{print $(NF-1)"/"$NF " " $0}' | fzf --reverse --header "New Session" --with-nth=1 | awk '{print $2}')
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
  tmux send-keys -t "$name:1" 'tmux set status on; set-env; nvim' C-m
  tmux select-window -t "$name:1"
  tmux switch-client -t "$name"
}

switch() {

  tmux list-sessions -F '#{session_name}' |
    sed '/^popup/d' |
    sed '/^scratch/d' |
    sed '/^$/d' |
    fzf --reverse --header 'Switch Session' --preview 'tmux capture-pane -pt {}' \
      --bind 'enter:execute(tmux switch-client -t {})+accept'

}

delete() {

  tmux list-sessions -F '#{session_name}' |
    sed '/^popup/d' |
    sed '/^scratch/d' |
    sed '/^general/d' |
    sed '/^$/d' |
    fzf --reverse --header 'Delete Session' --preview 'tmux capture-pane -pt {}' \
      --bind 'enter:execute(tmux kill-session -t {})+accept'
}

window() {
  current_window=$(tmux display-message -p '#I')

  window=$(tmux list-windows -F '#{window_index} #{window_name}' |
    sed "/^$/d" |
    grep -v "$current_window" |
    fzf --reverse --header 'Switch Window' --no-preview |
    cut -d ' ' -f 1)

  [ -z "$window" ] && return 1

  tmux select-window -t $window
}

notes() {
  name="notes"

  tmux has-session -t ${name} >/dev/null && {
    tmux attach-session -t ${name}
    return
  }
  tmux new-session -d -s "$name" -c "$HOME/Documents/notes"
  tmux new-session -s notes nvim Welcome.md

  sleep 1
  tmux send-keys -t "$name" 'tmux set -g status off;clear' C-m
  tmux send-keys -t "$name" 'nvim Welcome.md' C-m
  tmux attach-session -t "$name"
}

popup() {
  name="popup"

  tmux has-session -t ${name} >/dev/null && {
    tmux attach-session -t ${name}
    return
  }
  tmux new-session -d -s "$name" -c "$HOME"

  sleep 1
  tmux send-keys -t "$name" 'tmux set -g status off;clear' C-m
  tmux attach-session -t "$name"
}

scratch() {
  name="scratch"

  tmux has-session -t ${name} >/dev/null && {
    tmux attach-session -t ${name}
    return
  }
  tmux new-session -d -s "$name" -c "$HOME"

  sleep 1
  tmux send-keys -t "$name" 'tmux set -g status off;clear' C-m
  tmux send-keys -t "$name" 'nvim scratch' C-m
  tmux attach-session -t "$name"
}

case "$1" in
new) new $2 ;;
switch) switch ;;
delete) delete ;;
window) window ;;
notes) notes ;;
popup) popup ;;
scratch) scratch ;;
*) echo "Please enter an action" ;;
esac
