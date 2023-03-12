export COPYFILE_DISABLE=true
export EDITOR=${${commands[(i)nvim]:-${commands[(i)vim]:-nano}}}
export FZF_DEFAULT_COMMAND="find * \
    \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
    -o -name '*.app' -prune -print \
    -o -type f -print -o -type d -print -o -type l -print 2> /dev/null"
export FZF_DEFAULT_OPTS="-m --reverse --cycle --height=40% \
    --color=hl:1,hl+:1,bg+:0,info:8,border:0,prompt:4,pointer:4 \
    --color=marker:2,spinner:8,header:-1"
export GREP_COLORS='cx=90:mt=31:fn=32:ln=34:bn=33:se='
export LESS='-iR --follow-name'
export LESSHISTFILE=~/.local/state/less/history
export LS_COLORS=${(j.:.)=:-'di=34' 'ow=34;40' 'ln=35' {or,mi}'=7;31'
    'ex=91' '*'{'~',.{bak,log,swp,tmp,class,o,pyc,DS_Store}}'=90'}
if [[ -n $commands[nvim] ]]; then
  export MANPAGER='nvim +Man!'
fi
export PAGER='less'

alias grep="${commands[ggrep]+g}grep -E --color=auto"
alias ls="${commands[gls]+g}ls --color=auto"
alias rg='rg -S'
if [[ $COLORTERM == truecolor ]]; then
  alias tmux='tmux -T RGB'
fi
alias vim="vim -u $ZDOTDIR:h/vim/vimrc"
alias zmv='noglob zmv'
