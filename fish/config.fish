status is-interactive || return

fish_hybrid_key_bindings

bind -M insert ctrl-i nextd-or-forward-word
bind -M insert ctrl-o prevd-or-backward-word
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-z send-job-to-foreground

command -q fzf && fzf --fish | grep -v 'bind .* fzf-history-widget' | source

set -gx EDITOR (path basename (command -s hx vim nvim vi nano)[1])
set -gx PAGER less
set -gx LESS -iR --follow-name
set -gx MANPAGER less --use-color -Dd+b -DP+WK
set -gx MANROFFOPT -c

abbr --set-cursor b ssh bee-shpool-ssh%

abbr cdd cd ~/Desktop
abbr --set-cursor cdf cd \(path dirname %\)
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

abbr t set -g fish_theme

abbr -p anywhere --set-cursor w '(which %)'
abbr -p anywhere --set-cursor W '(realpath (which %))'
