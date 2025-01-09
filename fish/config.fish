status is-interactive || return

set -g fish_cursor_insert line blink
set -g fish_cursor_visual underscore
set -g fish_greeting
set -g fish_prompt_pwd_full_dirs 3

functions -e fish_mode_prompt

fish_hybrid_key_bindings

bind -M insert ctrl-enter accept-autosuggestion
bind -M insert ctrl-i nextd-or-forward-word
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-o prevd-or-backward-word
bind -M insert ctrl-z fg repaint

if command -q fzf
    fzf --fish 2>/dev/null | grep -v 'bind .* fzf-history-widget' | source
end

set -gx EDITOR (path basename (command -s hx vim nvim vi nano)[1])
set -gx LESS -iR --follow-name
set -gx --path LS_COLORS di=34 ow=34\;40 ln=35 {or,mi}=7\;31 ex=91 \
    \*{~,.{bak,log,swp,tmp,class,o,pyc,DS_Store,lock}}=90
set -gx MANPAGER less --use-color -Dd+b -DP+WK
set -gx MANROFFOPT -c
set -gx PAGER less

abbr m sssh mabe

abbr cdd cd ~/Desktop
abbr --set-cursor cdf cd '(path dirname %)'
abbr cdot cd (path dirname (path resolve $__fish_config_dir))

abbr clean fd -Hgx rm -v {} '\;' .DS_Store
abbr clip fish_clipboard_copy

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

abbr j jj
abbr jd jj describe
abbr je jj edit
abbr jl jj log
abbr jn jj next
abbr jp jj prev
abbr jr jj rebase

abbr -p anywhere --set-cursor w '(which %)'
abbr -p anywhere --set-cursor W '(realpath (which %))'
