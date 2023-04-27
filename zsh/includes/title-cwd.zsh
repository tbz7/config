__title_prefix=" ${HOST/.*}  –  "

if [[ $FONT_MODE == nerd ]]; then
  case $OSTYPE-$CPUTYPE in
    darwin*)      __title_prefix="󰀵 $__title_prefix";;
    linux*-arm*)  __title_prefix=" $__title_prefix";;
    linux*)       __title_prefix=" $__title_prefix";;
  esac
fi

function .title-cwd-precmd {
  echo -n "\e]2;${__title_prefix}zsh\e\\$__cwd_osc7"
}

function .title-cwd-preexec {
  local words=(${(z)3})
  while [[ $#words > 0 && $words[1] == *?=* ]]; do
    shift words
  done
  echo -n "\e]2;$__title_prefix${words[1]##*/}\e\\"
}

function .title-cwd-chpwd {
  local wezterm=${commands[wezterm]:-${WEZTERM_EXECUTABLE_DIR:+$WEZTERM_EXECUTABLE_DIR/wezterm}}
  if [[ -x $wezterm ]]; then
    __cwd_osc7=$($wezterm set-working-directory)
  else
    __cwd_osc7="\e]7;file://$HOST${PWD// /%20}\e\\"
  fi
}

.title-cwd-chpwd

add-zsh-hook precmd .title-cwd-precmd
add-zsh-hook preexec .title-cwd-preexec
add-zsh-hook chpwd .title-cwd-chpwd
