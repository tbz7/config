function .cursor-bar {
  echoti Ss 5
}

function .cursor-block {
  echoti Ss 2
}

function .cursor-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    .cursor-block
  else
    .cursor-bar
  fi
}

if [[ -n $terminfo[Ss] ]]; then
  add-zle-hook-widget line-init .cursor-bar
  add-zle-hook-widget line-finish .cursor-block
  add-zle-hook-widget keymap-select .cursor-keymap-select
fi
