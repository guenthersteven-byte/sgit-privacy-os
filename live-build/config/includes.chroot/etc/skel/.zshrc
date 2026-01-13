# sgit-privacy-live Zsh Configuration
# Modern, fast, privacy-respecting shell setup

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Better directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Key bindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# Modern CLI tool aliases (if available)
command -v eza &> /dev/null && alias ls='eza --icons --group-directories-first'
command -v eza &> /dev/null && alias ll='eza -la --icons --group-directories-first'
command -v eza &> /dev/null && alias tree='eza --tree --icons'
command -v bat &> /dev/null && alias cat='bat --paging=never'
command -v fd &> /dev/null && alias find='fd'
command -v rg &> /dev/null && alias grep='rg'

# Useful aliases
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias ports='ss -tulanp'
alias myip='curl -s https://ipinfo.io/ip'
alias update='sudo apt update && sudo apt upgrade'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'

# Podman aliases (Docker-compatible)
alias docker='podman'
alias docker-compose='podman-compose'

# Privacy tools
alias killswitch='sudo sgit-killswitch'
alias privacy='sgit-privacy-center'

# Claude Code alias
alias claude='npx @anthropic-ai/claude-code'

# Load zsh-autosuggestions if available
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting if available
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship prompt (installed via hook)
eval "$(starship init zsh 2>/dev/null)" || true

# Welcome message
echo ""
echo "  sgit-privacy-live - Digitale Souveranitat"
echo "  Type 'privacy' for privacy tools, 'claude' for AI assistance"
echo ""
