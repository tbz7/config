function .title-cwd-precmd {
  echo -n "\e]2;zsh\e\\$__cwd_osc7"
}

function .title-cwd-preexec {
  local words=(${(z)3})
  while [[ $#words > 0 && $words[1] == *?=* ]]; do
    shift words
  done
  echo -n "\e]2;${words[1]##*/}\e\\"
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
