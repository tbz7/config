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

function .scroll-then-clear-screen {
  local REPLY c
  echoti u7
  while read -rsk1 c && [[ $c != R ]]; do
    REPLY+=$c
  done
  echoti indn $[${${${REPLY#*\[}%%;*}:-$LINES} - 1]
  echoti cup 0 0
  zle redisplay
}

function .clear-screen-and-scrollback {
  zle clear-screen
  echo -n '\e[3J'
  zle redisplay
}

function .fg {
  zle push-line
  BUFFER=fg
  zle accept-line
}

zle -N clear-screen-and-scrollback .clear-screen-and-scrollback
zle -N scroll-then-clear-screen .scroll-then-clear-screen
zle -N fg .fg

bindkey -v
bindkey $terminfo[kbs] backward-delete-char
bindkey $terminfo[kcud1] down-line-or-search
bindkey $terminfo[kcuu1] up-line-or-search
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[kend] end-of-line
bindkey $terminfo[khome] beginning-of-line
bindkey '\e' vi-cmd-mode
bindkey '\eh' run-help
bindkey '\e^l' clear-screen-and-scrollback
bindkey '\et' transpose-words
bindkey '^k' vi-kill-eol
if [[ $TERM_PROGRAM != VTE ]]; then
  bindkey '^l' scroll-then-clear-screen
fi
bindkey '^n' down-line-or-search
bindkey '^p' up-line-or-search
bindkey '^r' history-incremental-search-backward
bindkey '^z' fg

if [[ -f ~/.local/share/zsh/fzf/shell/key-bindings.zsh ]]; then
  source ~/.local/share/zsh/fzf/shell/key-bindings.zsh
fi
