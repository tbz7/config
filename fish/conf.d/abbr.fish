status is-interactive || return

abbr cdd cd ~/Desktop
abbr cdf --set-cursor 'cd (path dirname %)'
abbr cdot cd (path dirname (path resolve $__fish_config_dir))
abbr clip fish_clipboard_copy
abbr e -f __fish_anyeditor
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
abbr m sssh mabe
abbr w -p anywhere --set-cursor '(realpath (which %))'
