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

# The exa plugin sets up an alias for 'ls' with '--icons' as the last argument.
# This causes an issue with completion.  The argument '--icons' takes an
# optional value, and completion tries to complete for it.  There is a PR to
# fix the issue, but it hasn't been merged yet.  As a workaround, redefine the
# alias for 'ls'.
alias ls='eza --icons --group-directories-first'

# The vim plugin configures the KEYTIMEOUT to 25.  The results in taking over a
# second to enter normal mode upon pressing the ESC key.  There is a PR to
# reduce the KEYTIMEOUT to 1, but it hasn't been merged yet.  As a workaround,
# we set the KEYTMEOUT value to 1.
export KEYTIMEOUT=1

alias -g L='| less'
alias -g G='| grep'
alias -g WL='| wc -l'
# alias -g -- --h='--help 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Configure key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
