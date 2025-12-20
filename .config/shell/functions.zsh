isSet() { [ ! -z "${1}" ]; }
isNotSet() { [ -z "${1}" ]; }

set-cred ()
{
  export BW_SESSION="$(bw unlock $(secret-tool lookup token bitwarden) --raw)"
  bw sync
  printf "$(bw get password cli-gitlab)" | secret-tool store --label='Gitlab Token for CLI' 'token' 'GITLAB_TOKEN' 
  printf "$(bw get password cli-ollama-token)" | secret-tool store --label='Ollama Token for CLI' 'token' 'OLLAMA_TOKEN' 
  printf "$(bw get password cli-litellm-token)" | secret-tool store --label='LiteLLM Token for CLI' 'token' 'LITELLM_TOKEN' 
  printf "$(bw get password cli-openai)" | secret-tool store --label='OpenAI Token for CLI' 'token' 'OPENAI_TOKEN' 
  printf "$(bw get password GEMINI_TOKEN)" | secret-tool store --label='Gemini Token for CLI' 'token' 'GEMINI_TOKEN' 
  printf "$(bw get password cli-anthropic)" | secret-tool store --label='Anthropic Token for CLI' 'token' 'ANTHROPIC_TOKEN' 

  unset BW_SESSION
}

set-env ()
{
  export GITLAB_TOKEN="$(secret-tool lookup token GITLAB_TOKEN)"
  export OLLAMA_TOKEN="$(secret-tool lookup token OLLAMA_TOKEN)"
  export LITELLM_TOKEN="$(secret-tool lookup token LITELLM_TOKEN)"
  export OPENAI_TOKEN="$(secret-tool lookup token OPENAI_TOKEN)"
  export GEMINI_TOKEN="$(secret-tool lookup token GEMINI_TOKEN)"
  export ANTHROPIC_TOKEN="$(secret-tool lookup token ANTHROPIC_TOKEN)"
}

clear-env ()
{
  unset GITLAB_TOKEN
  unset OLLAMA_TOKEN
  unset LITELLM_TOKEN
  unset OPENAI_TOKEN
  unset GEMINI_TOKEN
}

tmux-new () {
  ~/.config/scripts/sessions.sh new $1
}

goland-new () {
  ~/.config/scripts/sessions.sh goland-new $1
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

nvim-new () {
  ~/.config/scripts/nvim.sh $1
}

ai () {
  set-env
  nvim +CodeCompanionChat -c only
}

clone () {
  ~/.config/scripts/clone.sh clone $1 $2
}
