function .termdetect-query-term-program {
  printf ${1:-%s} $'\e''[>0q'
  read -st 1 -d '\'
  if [[ ${REPLY:4} == iTerm2* ]]; then
    REPLY=iTerm.app
  elif [[ ${REPLY:4} == WezTerm* ]]; then
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

function .termdetect-infer-iterm-font {
  printf ${1:-%s} $'\e'']1337;ReportVariable=cHJvZmlsZU5hbWU='$'\a'
  read -st 1 -d $'\a'
  if [[ ${REPLY:7} == 'ReportVariable=Q3VzdG9taXplZA=='* ]]; then
    export FONT_MODE=nerd
  else
    export FONT_MODE=unicode
  fi
}

case $TERM in
  linux*)
    export TERM=linux-16color
    export FONT_MODE=ascii;;
  tmux*)
    export COLORTERM=truecolor
    if [[ -z $FONT_MODE ]]; then
      .termdetect-query-term-program '\ePtmux;\e%s\e\\'
      case $REPLY in
        iTerm.app)
          .termdetect-infer-iterm-font '\ePtmux;\e%s\e\\';;
        WezTerm)
          export FONT_MODE=nerd;;
        VTE)
          export FONT_MODE=unicode13;;
      esac
    fi;;
  xterm-256color)
    if [[ -z $TERM_PROGRAM ]]; then
      if [[ -n $VTE_VERSION ]]; then
        export TERM_PROGRAM=VTE
      elif [[ $TERM == xterm-256color && -n $SSH_CONNECTION ]]; then
        .termdetect-query-term-program
        export TERM_PROGRAM=$REPLY
      fi
    fi
    case $TERM_PROGRAM in
      Apple_Terminal)
        export COLORTERM=256color
        export FONT_MODE=unicode;;
      iTerm.app)
        export COLORTERM=truecolor
        if [[ -z $FONT_MODE ]]; then
          .termdetect-infer-iterm-font
        fi;;
      VTE)
        export COLORTERM=truecolor
        export FONT_MODE=unicode13;;
      WezTerm)
        export COLORTERM=truecolor
        export FONT_MODE=nerd;;
    esac;;
esac
