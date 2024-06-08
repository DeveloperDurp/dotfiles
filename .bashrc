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
export BAT_THEME="Catppuccin Mocha"
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=none,fg=white,bold"
#eval $(thefuck --alias)
#
alias tf=terraform
alias k=kubectl
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias pwsh='pwsh -NoLogo'
alias pbpaste='xclip -selection clipboard -o'
alias ls='eza'
alias ll='eza -l'
alias tree='eza -T'
alias cat='bat'
alias network='nmtui'
alias docker='podman'
alias sudo='sudo '

eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/config.toml)"

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

