#export ZSH="$HOME/.oh-my-zsh"
export DEVPOD_DISABLE_TELEMETRY=true
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1 
export DOTNET_ROOT="/usr/share/dotnet"
export PROMPT_EOL_MARK=''
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
export EDITOR='nvim'
export GEM_HOME="$HOME/gems"
export GOBIN=~/go/bin
export BAT_THEME="Catppuccin Mocha"
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=none,fg=white,bold"
#eval $(thefuck --alias)
export GEM_HOME="$HOME/gems"
export XCURSOR_SIZE=24
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
eval "$(ssh-agent -s)" >> /dev/null

export PATH="$HOME/.local/bin:$HOME/gems/bin:/usr/local/go/bin:$HOME/go/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$HOME/.local/bin/DSC:$PATH"

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
