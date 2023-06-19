# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1 
export PROMPT_EOL_MARK=''

ZSH_THEME="avit"

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
alias docker="podman"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
