zload add-zle-hook-widget

declare -g FOCUSED

function __focus_events_setup {
  __focus_events_widget() {
    local initial=$FOCUSED
    case $WIDGET in
      focus-line-init)   echo -n "\e[?1004h";&
      focus-gained)      FOCUSED=true;;
      focus-line-finish) echo -n "\e[?1004l";&
      focus-lost)        FOCUSED=false;;
    esac
    if [[ $FOCUSED != $initial ]]; then
      zle zle-focus-change
    fi
  }

  zle -N focus-gained __focus_events_widget
  zle -N focus-lost __focus_events_widget
  zle -N focus-line-init __focus_events_widget
  zle -N focus-line-finish __focus_events_widget

  bindkey -a '\e[I' focus-gained '\e[O' focus-lost
  bindkey    '\e[I' focus-gained '\e[O' focus-lost
  add-zle-hook-widget line-init focus-line-init
  add-zle-hook-widget line-finish focus-line-finish
}

function __focus_events_define_zle_hook {
  local -aU hooktypes
  zstyle -a zle-hook types hooktypes
  zstyle zle-hook types $hooktypes focus-change

  eval "${${$(which azhw:zle-line-init)/line-init/focus-change}/\$WIDGET/zle-focus-change}"

  add-zle-hook-widget focus-change beep
  add-zle-hook-widget -d focus-change beep
}

__focus_events_setup
__focus_events_define_zle_hook
