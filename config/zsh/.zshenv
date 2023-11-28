export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export XAUTHORITY="${XDG_CONFIG_HOME}/X11/Xauthority"

export STACK_XDG=1
export GHCUP_USE_XDG_DIRS=1

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export GNUPHOME="${XGD_DATA_HOME}/gnupg"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
export XCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
export HISTFILE="${XDG_DATA_HOME}/zsh/history"

export LESSHISTFILE="${XDG_DATA_HOME}/less/history"

export HNEW="http://bbhackage.dev.bloomberg.com/stack/stack-templates/hpack.hsfiles"
