set-cred ()
{
  export BW_SESSION="$(bw unlock $(secret-tool lookup drive bitwarden) --raw)"
  bw sync
  printf "$(bw get password cli-gitlab)" | secret-tool store --label='Gitlab Token for CLI' 'token' 'GITLAB_TOKEN' 
  printf "$(bw get password cli-ollama-token)" | secret-tool store --label='Ollama Token for CLI' 'token' 'OLLAMA_TOKEN' 
  printf "$(bw get password cli-litellm-token)" | secret-tool store --label='LiteLLM Token for CLI' 'token' 'LITELLM_TOKEN' 

  unset BW_SESSION
}

set-env ()
{
  export GITLAB_TOKEN="$(secret-tool lookup token GITLAB_TOKEN)"
  export OLLAMA_TOKEN="$(secret-tool lookup token OLLAMA_TOKEN)"
  export LITELLM_TOKEN="$(secret-tool lookup token LITELLM_TOKEN)"
}

clear-env ()
{
  unset GITLAB_TOKEN
  unset OLLAMA_TOKEN
  unset LITELLM_TOKEN
}

tmux-new () {
  . $HOME/.config/scripts/new-session.sh
}

load-profile () {
  ansible-playbook /home/user/.dotfiles/ansible/.config/ansible/local.yml -K
}

decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}

decode-jwtpayload(){
   decode_base64_url $(echo -n $1 | cut -d "." -f '2') | jq .
}
decode-jwtheader(){
   decode_base64_url $(echo -n $1 | cut -d "." -f '1') | jq .
}
