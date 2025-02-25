status is-interactive || return

fish_hybrid_key_bindings

bind -M insert ctrl-enter accept-autosuggestion
bind -M insert ctrl-i nextd-or-forward-word
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-o prevd-or-backward-word
bind -M insert ctrl-t __fzf_files repaint
bind -M insert ctrl-z fg repaint

bind -M default J end-of-line 'commandline -i " "' delete-char

function __fzf_files
    set -l files (fzf --walker file,dir,follow,hidden --scheme path)
    commandline -i -- (string join ' ' (string escape $files))
end
