# Load utilities functions
fpath=($XDG_CONFIG_HOME/zsh/funcs $fpath)
autoload -U prepend-path-ifexist

# Configure PATH
PATH=$(prepend-path-ifexist "/bin")
PATH=$(prepend-path-ifexist "/opt/bb/bin")
PATH=$(prepend-path-ifexist "${XDG_CONFIG_HOME}/fzf/bin")
PATH=$(prepend-path-ifexist "${GOPATH}/bin")
PATH=$(prepend-path-ifexist "$HOME/.cabal/bin")
PATH=$(prepend-path-ifexist "$HOME/.ghcup/bin")
PATH=$(prepend-path-ifexist "$HOME/.local/bin")

# Configure prompt
PROMPT_LOCAL='
%(?:%{$fg_bold[green]%}✔:%{$fg_bold[red]%}✗) % %{$fg[cyan]%}%3~%{$reset_color%}${vcs_info_msg_0_}
%{$fg[yellow]%}$%{$reset_color%} '

PROMPT_REMOTE='
%(?:%{$fg_bold[green]%}✔:%{$fg_bold[red]%}✗) % %{$fg[cyan]%}%3~%{$reset_color%}${vcs_info_msg_0_}
%{$fg[yellow]%}%m % $%{$reset_color%} '

if [ -n "${SSH_TTY}" ]
then
    ZAP_PROMPT="${PROMPT_REMOTE}"
else
    ZAP_PROMPT="${PROMPT_LOCAL}"
fi

# Configure cursor shape
VICMD='\e[5 q'  # block for command mode
VIINS='\e[1 q'  # beam for insert mode
