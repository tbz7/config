export FONT_MODE=${FONT_MODE:-unicode}

if [[ $ITERM_PROFILE == Custom ]]; then
  FONT_MODE=nerd
elif [[ -n $VTE_VERSION ]]; then
  FONT_MODE=unicode13
elif [[ $TERM == linux* ]]; then
  FONT_MODE=ascii
  TERM=linux-16color
fi

iterm2_hostname=$HOST
if zload plugin/iterm2-shell-integration && 
    [[ $COLORTERM != truecolor || $FONT_MODE == unicode ]] && it2check; then
  export COLORTERM=truecolor
  if [[ $(it2profile -g) == 'Custom' ]]; then
    export FONT_MODE=nerd
  fi
fi

if [[ $COLORTERM != 'truecolor' ]]; then
  zload zsh/nearcolor
fi
