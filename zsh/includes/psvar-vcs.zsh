zmodload zsh/net/socket

__psvar_vcs=$1
__psvar_vcs_dir=$0:r
__psvar_vcs_socket=

function .psvar-vcs-precmd {
  .psvar-vcs-fetch 1 2> /dev/null
}

function .psvar-vcs-poll {
  local old=$psvar[$__psvar_vcs]
  .psvar-vcs-fetch 2> /dev/null
  if [[ $old != $psvar[$__psvar_vcs] ]]; then
    zle reset-prompt
  fi
}

function .psvar-vcs-fetch {
  local sock='/tmp/prompt-vcs' cmd parts=()
  case $FONT_MODE in
    nerd|powerline) local -A sym=(git  hg ☿);;
    unicode*)       local -A sym=(git ⇵ hg ☿);;
    *)              local -A sym=();;
  esac

  psvar[$__psvar_vcs]=

  if [[ -z $__psvar_vcs_socket ]]; then
    if zsocket $sock; then
      __psvar_vcs_socket=$REPLY
    else
      case "$OSTYPE/$CPUTYPE" in
        darwin*/arm64) cmd="$__psvar_vcs_dir/prompt-vcs-cacher_darwin_arm64";;
        linux*/x86_64) cmd="$__psvar_vcs_dir/prompt-vcs-cacher_linux_amd64";;
        linux*/arm*)   cmd="$__psvar_vcs_dir/prompt-vcs-cacher_linux_arm";;
        *) return 1;;
      esac
      rm -f $sock
      ($cmd $sock "$__psvar_vcs_dir/prompt-vcs" &)
      return 1
    fi
  fi

  if print -nu $__psvar_vcs_socket $(($1))$PWD:A; then
    IFS+=: read -ru $__psvar_vcs_socket -d $'\0' -t 1 -A parts
    if [[ -n $parts ]]; then
      psvar[$__psvar_vcs]="${sym[$parts[1]]:-@} $parts[2]${parts[3]:+ *}"
    fi
  else
    exec {__psvar_vcs_socket}>&-
    __psvar_vcs_socket=
    return 1
  fi
}

add-zsh-hook precmd .psvar-vcs-precmd

trap .psvar-vcs-poll ALRM
TMOUT=1
