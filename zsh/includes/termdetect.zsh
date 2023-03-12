#  iterm:  [term, font, color]  -- ssh -->  [term, font, color]
#  wez:    [term, font, color]  -- ssh -->  [term, font, color]
#  tmux:   [term,  *  , color]  -- ssh -->  [term,  *  , color]
#  vte:    [term,  -  , color]  -- ssh -->  [term,  -  , color]
#  apple:  [term,  -  , color]  -- ssh -->  [ -  ,  -  ,   -  ]

function .termdetect-safe-read {
  local char i=0
  REPLY=
  while (( i++ < 64 )) && [[ $char != $1 ]] && read -st 1 -k 1 char; do
    REPLY+=$char
  done
}

function .termdetect-query-iterm {
  echo -n '\e]1337;ReportVariable=cHJvZmlsZU5hbWU=\a'
  .termdetect-safe-read $'\a'
  if [[ ${REPLY:7} != 'ReportVariable='* ]]; then
    return 1
  elif [[ ${REPLY:7} == 'ReportVariable=Q3VzdG9taXplZA=='* ]]; then
    export FONT_MODE=nerd
  else
    export FONT_MODE=unicode
  fi
  export TERM_PROGRAM=iTerm.app
}

function .termdetect-query-vte {
  echo -n '\e[=0c'
  .termdetect-safe-read '\'
  if [[ ${REPLY:4:8} != '7E565445' ]]; then
    return 1
  fi
  export TERM_PROGRAM=VTE
}

function .termdetect-query-wezterm {
   echo -n '\e[>0q'
  .termdetect-safe-read '\'
  if [[ ${REPLY:4} != WezTerm* ]]; then
    return 1
  fi
  export TERM_PROGRAM=WezTerm
}

function .termdetect-query-tmux-client-font {
  echo -n '\ePtmux;\e\e]1337;ReportVariable=cHJvZmlsZU5hbWU=\a\e\\'
  .termdetect-safe-read $'\a'
  if [[ ${REPLY:7} == 'ReportVariable=Q3VzdG9taXplZA=='* ]]; then
    export FONT_MODE=nerd
  elif [[ ${REPLY:7} == 'ReportVariable='* ]]; then
    export FONT_MODE=unicode
  else
    echo -n '\ePtmux;\e\e[=0c\e\\'
    .termdetect-safe-read '\'
    if [[ ${REPLY:4:8} == '7E565445' ]]; then
      export FONT_MODE=unicode13
    else
      echo -n '\ePtmux;\e\e[>0q\e\\'
      .termdetect-safe-read '\'
       if [[ ${REPLY:4} != WezTerm* ]]; then
         return 1
       fi
       export TERM_PROGRAM=WezTerm
    fi
  fi
}

if [[ -z $TERM_PROGRAM ]]; then
  if [[ -n $VTE_VERSION ]]; then
    export TERM_PROGRAM=VTE
  elif [[ -n $SSH_CONNECTION ]]; then
    if [[ $TERM == xterm-256color ]]; then
      .termdetect-query-iterm \
          || .termdetect-query-vte \
          || .termdetect-query-wezterm
    elif [[ $TERM == tmux-256color ]]; then
      export TERM_PROGRAM=tmux
    fi
  fi
fi

case $TERM_PROGRAM in
  Apple_Terminal)
    export COLORTERM=256color
    export FONT_MODE=unicode;;
  iTerm.app)
    export COLORTERM=truecolor
    if [[ -z $FONT_MODE ]]; then
      .termdetect-query-iterm
    fi;;
  tmux)
    export COLORTERM=truecolor
    if [[ -z $FONT_MODE ]]; then
      .termdetect-query-tmux-client-font
    fi;;
  VTE)
    export COLORTERM=truecolor
    export FONT_MODE=unicode13;;
  WezTerm)
    export COLORTERM=truecolor
    export FONT_MODE=nerd;;
esac
