zload add-zsh-hook

setopt noautopushd

declare -g __nav_offset=-1

function __nav_chpwd {
  dirstack=($dirstack[1,__nav_offset] $PWD)
  __nav_offset=-1
}

function __nav_back {
  local f
  if (( __nav_offset > -$#dirstack )); then
    cd -q $dirstack[--__nav_offset]
    for f ($precmd_functions) $f
    zle reset-prompt
  fi
}

function __nav_forward {
  local f
  if (( __nav_offset < -1 )); then
    cd -q $dirstack[++__nav_offset]
    for f ($precmd_functions) $f
    zle reset-prompt
  fi
}

zle -N nav-back __nav_back
zle -N nav-forward __nav_forward

add-zsh-hook chpwd __nav_chpwd

dirstack=($PWD)
