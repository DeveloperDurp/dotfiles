# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1 
export PROMPT_EOL_MARK=''
#export EDITOR='nvim'
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

source $ZSH/oh-my-zsh.sh

export GEM_HOME="$HOME/gems"
export PATH="$HOME/.local/bin:$HOME/gems/bin:/usr/local/go/bin:$HOME/go/bin:$PATH"
export GOBIN=~/go/bin

unlockbw ()
{
  export BW_SESSION="$(bw unlock --raw)"
  export GITLAB_TOKEN="$(bw get password cli-gitlab)"
}
lockbw ()
{
  unset BW_SESSION
  unset GITLAB_TOKEN
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
