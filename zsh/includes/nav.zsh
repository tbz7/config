setopt autopushd

function .nav-chpwd {
  forward_dirstack=()
}

function .nav-back {
  if (( $#dirstack )); then
    local f saved=($PWD $forward_dirstack)
    popd > /dev/null
    forward_dirstack=($saved)

    for f ($precmd_functions) $f
    zle reset-prompt
  fi
}

function .nav-forward {
  if (( $#forward_dirstack )); then
    local f saved=($forward_dirstack)
    pushd $forward_dirstack[1] > /dev/null
    forward_dirstack=(${saved:1})

    for f ($precmd_functions) $f
    zle reset-prompt
  fi
}

add-zsh-hook chpwd .nav-chpwd

zle -N nav-back .nav-back
zle -N nav-forward .nav-forward
bindkey '\e[1;2D' nav-back
bindkey '\e[1;2C' nav-forward
