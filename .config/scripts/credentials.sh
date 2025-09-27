#!/usr/bin/zsh
source ~/.config/shell/functions.zsh

set() {
  export BW_SESSION="$(bw unlock $(secret-tool lookup drive bitwarden) --raw)"
  bw sync
  printf "$(bw get password cli-gitlab)" | secret-tool store --label='Gitlab Token for CLI' 'token' 'GITLAB_TOKEN'
  printf "$(bw get password cli-ollama-token)" | secret-tool store --label='Ollama Token for CLI' 'token' 'OLLAMA_TOKEN'
  printf "$(bw get password cli-litellm-token)" | secret-tool store --label='LiteLLM Token for CLI' 'token' 'LITELLM_TOKEN'
  printf "$(bw get password cli-openai)" | secret-tool store --label='OpenAI Token for CLI' 'token' 'OPENAI_TOKEN'
  printf "$(bw get password GEMINI_TOKEN)" | secret-tool store --label='Gemini Token for CLI' 'token' 'GEMINI_TOKEN'
  printf "$(bw get password cli-anthropic)" | secret-tool store --label='Anthropic Token for CLI' 'token' 'ANTHROPIC_TOKEN'

  unset BW_SESSION
}

get() {
  export GITLAB_TOKEN="$(secret-tool lookup token GITLAB_TOKEN)"
  export OLLAMA_TOKEN="$(secret-tool lookup token OLLAMA_TOKEN)"
  export LITELLM_TOKEN="$(secret-tool lookup token LITELLM_TOKEN)"
  export OPENAI_TOKEN="$(secret-tool lookup token OPENAI_TOKEN)"
  export GEMINI_TOKEN="$(secret-tool lookup token GEMINI_TOKEN)"
  export ANTHROPIC_TOKEN="$(secret-tool lookup token ANTHROPIC_TOKEN)"
}

case "$1" in
set) set ;;
get) get ;;
*) echo "Please enter an action" ;;
esac
