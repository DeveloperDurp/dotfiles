unlockbw ()
{
  export BW_SESSION="$(bw unlock $(secret-tool lookup drive bitwarden) --raw)"
  export GITLAB_TOKEN="$(bw get password cli-gitlab)"
  export OLLAMA_TOKEN="$(bw get password cli-ollama-token)"
}
lockbw ()
{
  unset BW_SESSION
  unset GITLAB_TOKEN
  unset OLLAMA_TOKEN
}

tmux-new () {
local dir=$(find $HOME/Documents/gitlab  -mindepth 1 -maxdepth 1 -type d| awk -F/ '{print $(NF-1)"/"$NF " " $0}' | fzf --with-nth=1 | awk '{print $2}')
  [ -z "$dir" ] && return 1

  local name=$(basename "$dir")
  tmux new-session -d -s "$name" -c "$dir"

  RIGHT_PANE_WIDTH=60
  BOTTOM_PANE_WIDTH=15

  tmux split-window -h -t "$name:1" -c "$dir"
  tmux resize-pane -t "$name:1.2" -x $RIGHT_PANE_WIDTH

  tmux split-window -v -t "$name:1.1" -c "$dir"
  tmux resize-pane -t "$name:1.1" -y $(($(tmux display -p '#{window_height}') - $BOTTOM_PANE_WIDTH))

  tmux new-window "$name" -n lazygit -c "$dir"

  sleep 1
  tmux send-keys -t "$name:1.1" 'nvim -c "Neotree filesystem reveal left"' C-m

  sleep 0.1
  tmux send-keys -t "$name:1.3" 'unlockbw; nvim +CodeCompanionChat -c only' C-m

  sleep 1
  tmux send-keys -t "$name:2" 'lg' C-m

  tmux select-window -t "$name:1"
  tmux select-pane -t "$name:1.1"
  tmux switch-client -t "$name"
}

load-profile () {
  ansible-playbook /home/user/.dotfiles/ansible/.config/ansible/local.yml -K
}

