PS1='%F{%(V.8.%(2V.6.4))}%m%f:%F{%(V.8.%(2V.3.2))}%33<...<%~%f %# '
RPS1='%(?..%1F%S x %s)%(3V.%8F%K %3v .)%f%k'
ZLE_RPROMPT_INDENT=0
ZLE_SPACE_SUFFIX_CHARS='&|'

function .theme-palette-preexec {
  if [[ $2 == ssh\ * ]]; then
    __palette_reset=1
  fi
}

function .theme-palette-precmd {
  if [[ $__palette_reset == 1 ]]; then
    theme apply --term
    unset __palette_reset
  fi
}

add-zsh-hook preexec .theme-palette-preexec
add-zsh-hook precmd .theme-palette-precmd

if [[ $TERM != linux* ]] theme apply
