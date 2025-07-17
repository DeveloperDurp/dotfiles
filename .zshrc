# Generate Completions if not found
if [ ! -f $HOME/.config/shell/fzf.completion.zsh ]; then
  fzf --zsh > $HOME/.config/shell/fzf.completion.zsh
fi

if [ ! -f $HOME/.config/shell/zoxide.completions.zsh ]; then
  zoxide init --cmd cd zsh > $HOME/.config/shell/zoxide.completions.zsh
fi

if [ ! -f $HOME/.config/shell/bw.completions.zsh ]; then
  bw completion --shell zsh > $HOME/.config/shell/bw.completions.zsh
fi

# Load seperated config files
for conf in "$HOME/.config/shell/"*.zsh; do
  source "${conf}"
done
unset conf

if command -v tmux &> /dev/null && [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]  && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    #cwd=$(pwd)
    #session_name="zJediTerm-$(basename "$cwd" | tr -d '.')"

    #if tmux has-session -t $session_name; then
    #    tmux attach -t $session_name
    #else
    #    tmux new-session -s $session_name -c $cwd -d
    #    tmux send-keys -t $session_name "tmux set-option status off;clear" Enter
    #    tmux attach -t $session_name
    #fi
fi

if command -v tmux &> /dev/null && [[ ! "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]  && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    session_name="general"

    if tmux has-session -t $session_name; then
        tmux attach -t $session_name
    else
        tmux new -s $session_name
    fi
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/config.toml)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

#zinit wait lucid for OMZP::{'git','sudo','archlinux','aws','kubectl','kubectx','command-not-found','web-search','jsontools','copypath','copyfile','copybuffer','dirhistory'}
# Add in snippets
#zinit snippet OMZP::git
#zinit snippet OMZP::sudo
#zinit snippet OMZP::archlinux
#zinit snippet OMZP::aws
#zinit snippet OMZP::kubectl
#zinit snippet OMZP::kubectx
#zinit snippet OMZP::command-not-found
#zinit snippet OMZP::web-search
#zinit snippet OMZP::jsontools
#zinit snippet OMZP::copypath
#zinit snippet OMZP::copyfile
#zinit snippet OMZP::copybuffer
#zinit snippet OMZP::dirhistory
#zinit snippet OMZP::history-substring-search

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey  "^[[1~" beginning-of-line
bindkey  "^[[4~" end-of-line
bindkey "^[l" forward-word
bindkey "^[h" backward-word
bindkey "^[[3~" delete-char

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
