set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_STATE_HOME ~/.local/state

set -gx FZF_DEFAULT_OPTS_FILE ~/.config/fzf/fzfrc
set -gx HOMEBREW_BUNDLE_FILE ~/.config/homebrew/Brewfile
set -gx INPUTRC ~/.config/readline/inputrc
set -gx JJ_CONFIG ~/.config/jj/config.toml
set -gx RIPGREP_CONFIG_PATH ~/.config/rg/rgrc

mkdir -p ~/.local/state/{less,python,sqlite3,vim}
set -gx LESSHISTFILE ~/.local/state/less/history
set -gx PYTHON_HISTORY ~/.local/state/python/history
set -gx SQLITE_HISTORY ~/.local/state/sqlite3/history

set -gx GOPATH ~/.cache/go
