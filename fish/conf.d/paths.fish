if test -d /opt/homebrew
    /opt/homebrew/bin/brew shellenv | source
else if test -d /home/linuxbrew/.linuxbrew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

fish_add_path -g $HOMEBREW_PREFIX/opt/{man-db,python}/libexec/bin
fish_add_path -g $HOMEBREW_PREFIX/opt/{coreutils,findutils,gnu-sed,gnu-tar,grep}/libexec/gnubin
fish_add_path -g ~/.local/bin

set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state

set -gx GOPATH ~/.cache/go

set -gx FZF_DEFAULT_OPTS_FILE ~/.config/fzf/fzfrc
set -gx HOMEBREW_BUNDLE_FILE ~/.config/homebrew/Brewfile
set -gx INPUTRC ~/.config/readline/inputrc
set -gx JJ_CONFIG ~/.config/jj/config.toml
set -gx RIPGREP_CONFIG_PATH ~/.config/rg/rgrc
set -gx WGETRC ~/.config/wget/wgetrc

mkdir -p ~/.local/state/{less,python,sqlite3,vim,wget}
set -gx LESSHISTFILE ~/.local/state/less/history
set -gx PYTHON_HISTORY ~/.local/state/python/history
set -gx SQLITE_HISTORY ~/.local/state/sqlite3/history
