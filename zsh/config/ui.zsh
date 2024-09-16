zload add-zsh-hook
zload colorscheme
zload lib/cursor-shapes
zload plugin/zsh-syntax-highlighting
zload promptinit; promptinit
zload vcs-monitor

colorscheme default

prompt zline -- -a '%m' -b '%33<…<%~' -e '%(?..✗)' -z '%1v'
vcs-monitor --psvar 1

function __title-set {
  echo -n "\e]0;${HOST/.*}  –  ${1-zsh}\a"
}
function __title-preexec {
  __title-set ${${${${(Az)3}/*=*}[1]}/*\/}
}
add-zsh-hook precmd __title-set
add-zsh-hook preexec __title-preexec
