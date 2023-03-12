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

bindkey -e
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[kend] end-of-line
bindkey $terminfo[khome] beginning-of-line
bindkey '^u' backward-kill-line
bindkey 'fd' vi-cmd-mode

function .fg {
  zle push-line
  BUFFER=fg
  zle accept-line
}

zle -N fg .fg
bindkey '^z' fg


if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
elif [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi
