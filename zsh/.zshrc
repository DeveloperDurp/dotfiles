# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1 
export PROMPT_EOL_MARK=''
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
export EDITOR='nvim'
export GEM_HOME="$HOME/gems"
export PATH="$HOME/.local/bin:$HOME/gems/bin:/usr/local/go/bin:$HOME/go/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
export GOBIN=~/go/bin
#eval $(thefuck --alias)
#
alias tf=terraform
alias k=kubectl
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

source ~/.fzf.completion.zsh
source ~/.fzf.key-bindings.zsh

unlockbw ()
{
  export BW_SESSION="$(bw unlock --raw)"
  export GITLAB_TOKEN="$(bw get password cli-gitlab)"
  export VAULT_UNSEAL="$(bw get password cli-vault-unseal)"
  export VAULT_TOKEN="$(bw get password vault.internal.durp.info)"
}
lockbw ()
{
  unset BW_SESSION
  unset GITLAB_TOKEN
  unset VAULT_UNSEAL
  unset VAULT_TOKEN
}

unlockvault() {
    local POD_NAME="vault-0"
    local NAMESPACE="vault"
    local UNSEAL_KEY=$VAULT_UNSEAL
    local PASSWORD=$VAULT_TOKEN
    local K8S_API_SERVER=$(kubectl exec -it $POD_NAME -n $NAMESPACE -- printenv | grep KUBERNETES_SERVICE_HOST | cut -d "=" -f2)
    local JWT=$(kubectl exec -it $POD_NAME -n $NAMESPACE -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)

    kubectl exec -it $POD_NAME -n $NAMESPACE -- /bin/sh << EOF
    vault operator unseal $UNSEAL_KEY
    vault login $PASSWORD
    vault write auth/kubernetes/config \
       token_reviewer_jwt="${JWT}" \
       kubernetes_host="https://${K8S_API_SERVER}:443" \
       kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
EOF
}

load-profile () {
  ansible-playbook /home/user/.dotfiles/ansible/.config/ansible/local.yml -K
}
#eval "$(bw completion --shell zsh); compdef _bw bw;"
#
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
## Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
#eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
