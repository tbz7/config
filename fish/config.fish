status is-interactive || return

set -g fish_cursor_default block
set -g fish_cursor_external line
set -g fish_cursor_insert line blink
set -g fish_cursor_replace_one underscore blink
set -g fish_cursor_replace underscore
set -g fish_cursor_visual underscore
set -g fish_vi_force_cursor 1
set -g iterm2_hostname $hostname

source $__fish_config_dir/themes/tokyonight.fish

fish_vi_key_bindings

bind -M insert \e\[105\;5u nextd-or-forward-word
bind -M insert \e\[1\;2C nextd-or-forward-word
bind -M insert \cO prevd-or-backward-word
bind -M insert \e\[1\;2D prevd-or-forward-word
bind -M insert \cK kill-line
bind -M insert \cN history-prefix-search-forward
bind -M insert \cP history-prefix-search-backward
bind -M insert \et transpose-words
bind -M insert \cz 'fg; commandline -f repaint'

set -gx PAGER less
set -gx EDITOR vi
for e in hx nvim vim
    command -sq $e && set EDITOR $e && break
end

set -gx COPYFILE_DISABLE true
set -gx FZF_DEFAULT_OPTS -m --reverse --cycle --height=40% \
    --color=hl:1,hl+:1,bg+:0,info:8,border:0,prompt:4,pointer:4,marker:2,spinner:8,header:-1
set -gx GOPATH ~/.cache/go
set -gx --path GREP_COLORS cx=90 mt=31 fn=32 ln=34 bn=33 se=
set -gx INPUTRC ~/.config/readline/inputrc
set -gx JJ_CONFIG ~/.config/jj/config.toml
set -gx LESS -iR --follow-name
set -gx LESSHISTFILE ~/.local/state/less/history
set -gx --path LS_COLORS di=34 ow=34\;40 ln=35 {or,mi}=7\;31 ex=91 \
    \*{~,.{bak,log,swp,tmp,class,o,pyc,DS_Store,lock}}=90
set -gx MANPAGER less --use-color -Dd+b -DP+WK
set -gx MANROFFOPT -c
set -gx PYTHON_HISTORY ~/.local/state/python/history
set -gx SQLITE_HISTORY ~/.local/state/sqlite3/history

alias clip fish_clipboard_copy
alias ncdu 'ncdu --color off'
alias rg 'rg -S'
alias sqlite3 "LS_COLORS= command sqlite3 --cmd '.mode qbox'"

abbr cdd cd ~/Desktop
abbr cdot cd (path dirname (path resolve $__fish_config_dir))
abbr cdn cd $NIX_PROFILES[1]

abbr e $EDITOR

abbr g git status
abbr ga git add
abbr gb git branch
abbr gc git checkout
abbr gcm git commit -m
abbr gcma git commit --amend --no-edit
abbr gd git difftool
abbr gds git diff --stat
abbr gl git l
abbr gm git difftool -g --dir-diff
abbr gr git rebase

abbr np nix profile
abbr npi nix profile install
abbr npl nix profile list
abbr npr nix profile remove
abbr npu nix profile upgrade --all

abbr t theme

abbr -p anywhere --set-cursor w '(which %)'
abbr -p anywhere --set-cursor W '(realpath (which %))'
