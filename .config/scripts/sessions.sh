#!/usr/bin/zsh
source $HOME/.config/shell/functions.zsh

new() {

  dir=${1:-}

  if [ -z "${dir}" ]; then

   name=$(find "$HOME/Documents/gitlab" -mindepth 2 -maxdepth 2 -type d \
        | awk -F/ '{print $(NF-1)"/"$NF}' \
        | sort \
        | wofi -dmenu -i -p "New Session" --columns 1)

    if [ -z "$name" ]; then
        return
    fi

  if [ -d "$name" ]; then
      dir="$name"
    else
        # If 'name' isn't a directory, assume it's a subfolder name and search within "Documents/gitlab"
        dir=$(find "$HOME/Documents/gitlab" -mindepth 2 -maxdepth 2 -type d | grep "$name$" | head -n 1)

        if [ -z "$dir" ]; then
            echo "Error: Directory not found for '$name' in Documents/gitlab." >&2
            return 1  # Or exit, depending on your script's error handling
        fi
    fi
  fi

  if [ -z "$dir" ]; then
      return
  fi

  name=$(basename "$dir")
  if [[ $name == .* ]]; then
    name=${name#.}
  fi

  tmux has-session -t ${name} 2>/dev/null && {
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

goland-new() {

  dir=${1:-}

  if [ -z "${dir}" ]; then

   name=$(find "$HOME/Documents/gitlab" -mindepth 2 -maxdepth 2 -type d \
        | awk -F/ '{print $(NF-1)"/"$NF}' \
        | sort \
        | wofi -dmenu -i -p "New JetBrains Session" --columns 1)

  if [ -z "$name" ]; then
      return
  fi

  dir=$(find "$HOME/Documents/gitlab" -mindepth 2 -maxdepth 2 -type d | grep "$name$" | head -n 1)

  fi

  if [ -z "$dir" ]; then
      return
  fi

  name=$(basename "$dir")
  if [[ $name == .* ]]; then
    name=${name#.}
  fi

  if [[ $dir == *'dotnet'* ]]; then
    /home/user/.local/share/JetBrains/Toolbox/apps/rider/bin/rider $dir &
  elif [[ $dir == *'go'* ]]; then
    /home/user/.local/share/JetBrains/Toolbox/scripts/goland $dir &
  elif [[ $dir == *'devops'* ]]; then
    /home/user/.local/share/JetBrains/Toolbox/scripts/goland $dir &
  fi
  #sleep 1 && /home/user/.local/share/JetBrains/Toolbox/apps/goland/bin/goland $dir &
}

switch() {

  session=$(tmux list-sessions -F '#{session_name}' |
    sed '/^popup/d' |
    sed '/^scratch/d' |
    sed '/^$/d' |
    fzf --reverse --header 'Switch Session' --no-preview)

  [ -z "$session" ] && return 1

  tmux switch-client -t $session
}

delete() {

  session=$(tmux list-sessions -F '#{session_name}' |
    sed '/^popup/d' |
    sed '/^scratch/d' |
    sed '/^general/d' |
    sed '/^$/d' |
    fzf --reverse --header 'Delete Session' --no-preview)

  [ -z "$session" ] && return 1

  tmux kill-session -t $session
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

test() {

menu_items=$(
  i=1
  local items=()
  tmux list-windows -F '#{window_name}' |
    while read -r window_name; do
      items+=("$(printf '%s %d "select-window -t %s"' "$window_name" "$i" "$window_name")")
      i=$((i + 1))
    done
  printf '%s\n' "${items[@]}"
)

  # Execute the command using tmux command-prompt
  printf "tmux display-menu -x 20 -y 8 $(printf $menu_items)"
  eval $(printf "tmux display-menu -x 20 -y 8 $(printf $menu_items)")
}

case "$1" in
new) new $2 ;;
switch) switch ;;
delete) delete ;;
window) window ;;
notes) notes ;;
popup) popup ;;
scratch) scratch ;;
goland-new) goland-new $2 ;;
test) test ;;
*) echo "Please enter an action" ;;
esac
