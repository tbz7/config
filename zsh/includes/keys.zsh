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
  zle clear-screen
  echo -n '\e[3J'
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
bindkey $terminfo[kbs] backward-delete-char
bindkey $terminfo[kcud1] down-line-or-search
bindkey $terminfo[kcuu1] up-line-or-search
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[kend] end-of-line
bindkey $terminfo[khome] beginning-of-line
bindkey '\e' vi-cmd-mode
bindkey '\e^l' clear-screen-and-history
bindkey '\eh' run-help
bindkey '\et' transpose-words
bindkey '^k' vi-kill-eol
bindkey '^n' down-line-or-search
bindkey '^p' up-line-or-search
bindkey '^r' history-incremental-search-backward
bindkey '^z' fg

if [[ -f ~/.local/share/zsh/fzf/shell/key-bindings.zsh ]]; then
  source ~/.local/share/zsh/fzf/shell/key-bindings.zsh
fi
