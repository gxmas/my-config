if [ -f "${XDG_DATA_HOME}/zap/zap.zsh" ]
then
    source "${XDG_DATA_HOME}/zap/zap.zsh"

    plug "${ZDOTDIR}/env-pre.zsh"

    plug "gxmas/zap-prompt"
    plug "zap-zsh/vim"
    plug "zap-zsh/exa"
    plug "zap-zsh/completions"
    plug "zsh-users/completions"
    plug "zsh-users/zsh-autosuggestions"
    plug "zsh-users/zsh-syntax-highlighting"
    plug "zsh-users/zsh-history-substring-search"
    plug "Aloxaf/fzf-tab"

    plug "${ZDOTDIR}/env-post.zsh"
fi
