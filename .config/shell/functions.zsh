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
  local -r name=${(U)1-"$(basename $(pwd))"}
  tmux new-session -d -s $name
  tmux switch-client -t $name
}

load-profile () {
  ansible-playbook /home/user/.dotfiles/ansible/.config/ansible/local.yml -K
}

