zload add-zle-hook-widget
zload zsh/terminfo

function __cursor_shape_update {
  if [[ -z $terminfo[Ss] ]]; then
    return 1
  fi
  if [[ $KEYMAP == vicmd || $WIDGET == cursor-reset ]]; then
    echoti Ss 2
  else
    echoti Ss 5
  fi
}

zle -N cursor-update __cursor_shape_update
zle -N cursor-reset __cursor_shape_update

add-zle-hook-widget line-init cursor-update
add-zle-hook-widget line-finish cursor-reset
add-zle-hook-widget keymap-select cursor-update
