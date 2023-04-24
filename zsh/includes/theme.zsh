source $ZDOTDIR/includes/psvar-focus.zsh 1
source $ZDOTDIR/includes/psvar-vicmd.zsh 2
source $ZDOTDIR/includes/psvar-vcs.zsh 3

ZLE_RPROMPT_INDENT=0
ZLE_SPACE_SUFFIX_CHARS='&|'

if [[ $FONT_MODE == ascii ]]; then
  PS1='%F{%(V.8.%(2V.6.4))}%m%f:%F{%(V.8.%(2V.3.2))}%33<...<%~%f %# '
  RPS1='%(?..%1F%S x %s)%(3V.%8F%K %3v .)%f%k'
  return
fi

function theme {
  local save=false
  if [[ $1 == -s ]]; then
    save=true
    shift
  fi

  if ! [[ -f $ZDOTDIR:h/common/themes/$1.lua ]]; then
    echo "Invalid theme: $1" >&2
    1=${THEME:-iceberg}
  elif $save; then
    mapfile[$HOME/.local/state/zsh/theme]=$1
  fi
  export THEME=$1

  local -A palette=(
      $(tail -n +2 $ZDOTDIR:h/common/themes/$THEME.lua | tr -d "=',{}"))

  case $FONT_MODE in
    nerd|powerline) local -A sym=(    ✗ ✗ ↳ ↳ … …);;
    unicode13)      local -A sym=( 🭮  🭬 ✗ ✗ ↳ ↳ … …);;
    *)              local -A sym=( ''  '' ✗ ✗ ↳ ↳ … …);;
  esac

  local a=$'\a' e=$'\e' x
  for x in afg abg bfg bbg cfg cbg; do
    local $x="%(V.$palette[${x}i].%(2V.$palette[${x}2].$palette[$x]))"
  done

  local efg="%(V.$palette[cfgi].$palette[efg])"
  local ebg="%(V.$palette[cbgi].$palette[ebg])"

  PS1="%{$e]133;D;%?;aid=$$$a$e]133;A;cl=m;aid=$$$a%}%F{$afg}%K{$abg} %m %F"
  PS1+="{$abg}%K{$bbg}$sym[]%F{$bfg} %33<$sym[…]<%~ %k%F{$bbg}$sym[] %f"
  PS1+="%{$e]133;B$a%}"
  RPS1="%{$e]133;P;k=r$a%}%(?..%F{$ebg}$sym[]%F{$efg}%K{$ebg} $sym[✗] %(3V.%F"
  RPS1+="{$cbg}$sym[].))%(3V.%(?.%F{$cbg}$sym[].)%F{$cfg}%K{$cbg} %3v .)%f%k"
  PS2="%{$e]133;P;k=s$a%}%8F$sym[↳]  %f%{$e]133;B$a%}"
  RPS2="%{$e]133;P;k=r$a%}%8F %1^%f"

  local code name hex
  for code name (
      '4;0'   'black'
      '4;1'   'red'
      '4;2'   'green'
      '4;3'   'yellow'
      '4;4'   'blue'
      '4;5'   'magenta'
      '4;6'   'cyan'
      '4;7'   'white'
      '4;8'   'bright_black'
      '4;9'   'bright_red'
      '4;10'  'bright_green'
      '4;11'  'bright_yellow'
      '4;12'  'bright_blue'
      '4;13'  'bright_magenta'
      '4;14'  'bright_cyan'
      '4;15'  'bright_white'
       '10'   'fg'
       '11'   'bg'
       '12'   'cursor_bg'
       '17'   'visual_bg'
       '19'   'visual_fg') {
    hex=$palette[$name]
    __theme_precmd_seqs+="\e]$code;rgb:${hex:1:2}/${hex:3:2}/${hex:5:2}\a"
  }

  __theme_precmd_seqs+="\e]1337;SetUserVar=theme="
  __theme_precmd_seqs+="$(echo -n $THEME | base64 | tr -d '\r\n')\a"
}

theme ${THEME:-${mapfile[$HOME/.local/state/zsh/theme]:-iceberg}}

function .theme-preexec {
  echo -n "\e]133;C\a"
}

function .theme-precmd {
  echo -n $__theme_precmd_seqs
}

add-zsh-hook preexec .theme-preexec
add-zsh-hook precmd .theme-precmd
