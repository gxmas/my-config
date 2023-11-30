# Configure mask
umask 022

# Configure zsh options
setopt auto_cd

# Export extra environment variables
export EDITOR=nvim
export PAGER='bat -p'
export LESS=-sFRMX
export MANPAGER="sh -c 'col -bx | bat --language=man -p'"
export MANROFFOPT='-c'

# Configure aliases
alias cat='bat -p'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ki='kinit --keychain gnoel@ADDEV.BLOOMBERG.COM'

alias -g L='| less'
alias -g G='| grep'
alias -g WL='| wc -l'
# alias -g -- --h='--help 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Configure key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
