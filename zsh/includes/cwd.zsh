function .cwd-update {
  local wezterm=${commands[wezterm]:-${WEZTERM_EXECUTABLE_DIR:+$WEZTERM_EXECUTABLE_DIR/wezterm}}
  if [[ -x $wezterm ]]; then
    __cwd_osc7=$($wezterm set-working-directory)
  else
    __cwd_osc7="\e]7;file://$HOST${PWD// /%20}\e\\"
  fi
}

function .cwd-output {
  echo -n $__cwd_osc7
}

.cwd-update

add-zsh-hook chpwd .cwd-update
add-zsh-hook precmd .cwd-output
