__psvar_focus=$1

function .psvar-focus-precmd {
  psvar[$__psvar_focus]=
}

function .psvar-focus-line-init {
  echo -n "\e[?1004h"
}

function .psvar-focus-line-finish {
  echo -n "\e[?1004l"
  psvar[$__psvar_focus]=0
  zle reset-prompt
}

function .psvar-focus-gained {
  psvar[$__psvar_focus]=
  zle reset-prompt
}

function .psvar-focus-lost {
  psvar[$__psvar_focus]=0
  zle reset-prompt
}

add-zsh-hook precmd .psvar-focus-precmd
add-zle-hook-widget line-init .psvar-focus-line-init
add-zle-hook-widget line-finish .psvar-focus-line-finish

zle -N .psvar-focus-gained
zle -N .psvar-focus-lost
bindkey -a '\e[I' .psvar-focus-gained '\e[O' .psvar-focus-lost
bindkey    '\e[I' .psvar-focus-gained '\e[O' .psvar-focus-lost
