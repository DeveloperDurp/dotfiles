# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1 
export PROMPT_EOL_MARK=''
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
export EDITOR='nvim'
#eval $(thefuck --alias)
ZSH_THEME="frisk"

plugins=(
  git
  zsh-autosuggestions
  sudo
  web-search
  copypath
  copyfile
  copybuffer
  dirhistory
  jsontools
  kubectl
)
source ~/.fzf.completion.zsh
source ~/.fzf.key-bindings.zsh
source $ZSH/oh-my-zsh.sh

export GEM_HOME="$HOME/gems"
export PATH="$HOME/.local/bin:$HOME/gems/bin:/usr/local/go/bin:$HOME/go/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
export GOBIN=~/go/bin

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
fuck () {
    TF_PYTHONIOENCODING=$PYTHONIOENCODING;
    export TF_SHELL=zsh;
    export TF_ALIAS=fuck;
    TF_SHELL_ALIASES=$(alias);
    export TF_SHELL_ALIASES;
    TF_HISTORY="$(fc -ln -10)";
    export TF_HISTORY;
    export PYTHONIOENCODING=utf-8;
    TF_CMD=$(
        thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
    ) && eval $TF_CMD;
    unset TF_HISTORY;
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
    test -n "$TF_CMD" && print -s $TF_CMD
}
alias tf=terraform
alias k=kubectl

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

reload-cache () {
  ssh root@192.168.21.254 umount -A /mnt/pve/cache-domains && mount -a
  ssh root@192.168.21.253 umount -A /mnt/pve/cache-domains && mount -a
  ssh root@192.168.21.252 umount -A /mnt/pve/cache-domains && mount -a
}
reload-domains () {
  ssh root@192.168.21.254 umount -A /mnt/pve/domains && mount -a
  ssh root@192.168.21.253 umount -A /mnt/pve/domains && mount -a
  ssh root@192.168.21.252 umount -A /mnt/pve/domains && mount -a
}

#eval "$(bw completion --shell zsh); compdef _bw bw;"
