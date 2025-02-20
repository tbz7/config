if test -d /opt/homebrew
    /opt/homebrew/bin/brew shellenv | source
else if test -d /home/linuxbrew/.linuxbrew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

fish_add_path -g $HOMEBREW_PREFIX/opt/{man-db,python}/libexec/bin
fish_add_path -g $HOMEBREW_PREFIX/opt/{coreutils,findutils,gnu-sed,gnu-tar,grep}/libexec/gnubin
fish_add_path -g ~/.local/bin

set -gx EDITOR (path basename (command -s hx vim nvim vi nano)[1])
set -gx FZF_DEFAULT_OPTS_FILE ~/.config/fzf/fzfrc
set -gx HOMEBREW_BUNDLE_FILE ~/.config/homebrew/Brewfile
set -gx INPUTRC ~/.config/readline/inputrc
set -gx JJ_CONFIG ~/.config/jj/config.toml
set -gx LESS -iR --follow-name
set -gx LESSHISTFILE ~/.local/state/less/history
set -gx --path LS_COLORS 'di=34' 'ex=91' 'ln=35' 'mi=7;31' 'or=7;31' 'ow=34;40' \
    '*.'{bak,class,DS_Store,lock,log,o,pyc,swp,tmp}'=90'
set -gx MANPAGER less --use-color -Dd+b -DP+Wk
set -gx MANROFFOPT -c
set -gx PAGER less
set -gx PYTHON_HISTORY ~/.local/state/python/history
set -gx RIPGREP_CONFIG_PATH ~/.config/rg/rgrc
set -gx SQLITE_HISTORY ~/.local/state/sqlite3/history
set -gx WGETRC ~/.config/wget/wgetrc
