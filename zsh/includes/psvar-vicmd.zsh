__psvar_vicmd=$1

function .psvar-vicmd-precmd {
  psvar[$__psvar_vicmd]=
}

function .psvar-vicmd-keymap-select {
  psvar[$__psvar_vicmd]=
  if [[ $KEYMAP == vicmd ]]; then
    psvar[$__psvar_vicmd]=1
  fi
  zle reset-prompt
}

add-zsh-hook precmd .psvar-vicmd-precmd
add-zle-hook-widget keymap-select .psvar-vicmd-keymap-select
