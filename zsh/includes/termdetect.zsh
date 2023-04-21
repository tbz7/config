function .termdetect-query-term-program {
  echo -n '\e[>0q'
  read -st 1 -d '\'
  if [[ ${REPLY:4} == WezTerm* ]]; then
    export TERM_PROGRAM=WezTerm
  else
    printf ${1:-%s} $'\e''[=0c'
    read -st 1 -k 2
    if [[ $REPLY[2] == 'P' ]]; then
      read -st 1 -d '\'
      if [[ ${REPLY:2:8} == '7E565445' ]]; then
        export TERM_PROGRAM=VTE
      fi
    elif [[ $REPLY[2] == '[' ]]; then
      read -st 1 -d 'c'
    fi
  fi
}

case $TERM in
  linux*)
    export TERM=linux-16color
    export FONT_MODE=ascii;;
  xterm-256color)
    if [[ -z $TERM_PROGRAM ]]; then
      if [[ -n $VTE_VERSION ]]; then
        export TERM_PROGRAM=VTE
      elif [[ -n $SSH_CONNECTION ]]; then
        .termdetect-query-term-program
      fi
    fi
    case $TERM_PROGRAM in
      VTE)
        export COLORTERM=truecolor
        export FONT_MODE=unicode13;;
      WezTerm)
        if infocmp wezterm &> /dev/null; then
          TERM=wezterm
        fi
        export COLORTERM=truecolor
        export FONT_MODE=nerd;;
      *)
        export FONT_MODE=unicode;;
    esac;;
esac

if [[ $COLORTERM != truecolor ]]; then
  zmodload zsh/nearcolor
fi
