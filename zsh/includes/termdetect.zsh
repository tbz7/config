function .termdetect-query-term-program {
  echo -n '\e[>0q'
  read -st 1 -d '\'
  if [[ ${REPLY:4} == WezTerm* ]]; then
    REPLY=WezTerm
  else
    printf ${1:-%s} $'\e''[=0c'
    read -st 1 -k 2
    if [[ $REPLY[2] == 'P' ]]; then
      read -st 1 -d '\'
      if [[ ${REPLY:2:8} == '7E565445' ]]; then
        REPLY=VTE
        return
      fi
    elif [[ $REPLY[2] == '[' ]]; then
      read -st 1 -d 'c'
    fi
    unset REPLY
    return 1
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
        export TERM_PROGRAM=$REPLY
      fi
    fi
    case $TERM_PROGRAM in
      Apple_Terminal)
        export COLORTERM=256color
        export FONT_MODE=unicode;;
      VTE)
        export COLORTERM=truecolor
        export FONT_MODE=unicode13;;
      WezTerm)
        if infocmp wezterm &> /dev/null; then
          TERM=wezterm
        fi
        export COLORTERM=truecolor
        export FONT_MODE=nerd;;
    esac;;
esac
