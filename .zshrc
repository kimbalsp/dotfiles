setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
eval "$(starship init zsh)"

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export LANG=en_US.UTF-8

export EDITOR=nvim

# --- VIM ---
alias v=nvim

# --- Eza ---
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2 --icons --git"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/Users/spencerkimball/.spicetify

export PATH="$HOME/.rbenv/shims:$PATH"

# --- Television ---

eval "$(tv init zsh)"

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# --- TheFuck ---

# thefuck alias
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# --- Zoxide (better cd) ---
eval "$(zoxide init zsh)"

alias cd="z"

alias python="python3"

# --- Yazi Setup ---
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export PATH="$HOME/.local/bin:$PATH"

# Sesh cc session
alias claude-sesh="~/.config/sesh/cc.sh"
