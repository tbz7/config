status is-interactive || return

abbr c cd (path dirname (path resolve $__fish_config_dir))
abbr cdd cd ~/Desktop
abbr cdf --set-cursor 'cd (path dirname %)'
abbr clip fish_clipboard_copy
abbr e -f __fish_anyeditor
abbr m sssh mabe
abbr w -p anywhere --set-cursor '(realpath (which %))'

abbr g git status
abbr ga git add
abbr gb git branch
abbr gc git checkout
abbr gcm git commit -m
abbr gcma git commit --amend --no-edit
abbr gd git diff
abbr gds git diff --stat
abbr gdt git difftool
abbr gl git log --oneline
abbr gr git rebase

abbr j jj status
abbr jd jj diff
abbr je jj edit
abbr jl jj log
abbr jn jj new
abbr jr jj rebase
