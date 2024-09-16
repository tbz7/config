zload lib/nav-widgets

function __fg {
  zle push-line
  BUFFER=fg
  zle accept-line
}
zle -N fg __fg

bindkey -v
bindkey '\e[1;2C' nav-forward '\e[105;5u' nav-forward
bindkey '\e[1;2D' nav-back '^o' nav-back
bindkey '\e[1~' beginning-of-line '\e[H' beginning-of-line
bindkey '\e[3~' delete-char
bindkey '\e[4~' end-of-line '\e[F' end-of-line
bindkey '\eh' run-help
bindkey '\et' transpose-words
bindkey '^?' backward-delete-char '^H' backward-delete-char
bindkey '^k' vi-kill-eol
bindkey '^n' down-line-or-search
bindkey '^p' up-line-or-search
bindkey '^r' history-incremental-search-backward
bindkey '^z' fg

eval "$(fzf --zsh 2>/dev/null)"
