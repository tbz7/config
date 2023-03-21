if [[ -n $terminfo[smkx] && -n $terminfo[rmkx] ]]; then
  function .keys-line-init {
    echoti smkx
  }
  function .keys-line-finish {
    echoti rmkx
  }
  add-zle-hook-widget line-init .keys-line-init
  add-zle-hook-widget line-finish .keys-line-finish
fi

function .clear-screen-and-history {
  echoti clear
  echoti E3
  zle redisplay
}
zle -N clear-screen-and-history .clear-screen-and-history

function .fg {
  zle push-line
  BUFFER=fg
  zle accept-line
}
zle -N fg .fg

bindkey -v
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[kend] end-of-line
bindkey $terminfo[khome] beginning-of-line
bindkey '\e' vi-cmd-mode
bindkey '\eh' run-help
bindkey '\et' transpose-words
bindkey '^?' backward-delete-char
bindkey '^k' vi-kill-eol
bindkey '^n' down-line-or-search
bindkey '^p' up-line-or-search
bindkey '^r' history-incremental-search-backward
bindkey '^xl' clear-screen-and-history
bindkey '^z' fg

if [[ -f ~/.local/share/zsh/fzf/shell/key-bindings.zsh ]]; then
  source ~/.local/share/zsh/fzf/shell/key-bindings.zsh
fi
