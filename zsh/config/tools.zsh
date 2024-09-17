# cd
alias    cdd='cd ~/Desktop'
function cdf { cd $1:A:h }
alias    cdot="cd $ZDOTDIR:A:h"
hash -d icloud=~/Library/Mobile\ Documents/com~apple~CloudDocs
hash -d nix=$nix_profiles[1]

# clean
function clean {
  find ${1-.} -name .DS_Store -print -delete
}

# colorscheme
alias c='colorscheme'

# diff
if [[ -n $commands[colordiff] ]]; then
  alias diff='colordiff --nobanner'
fi

# editor
export EDITOR=${commands[(i)hx]:-${${commands[(i)nvim]:-${commands[(i)vim]:-vi}}}}
alias e=$EDITOR

# git
alias g='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git checkout'
alias gcm='git commit -m'
alias gcma='git commit --amend --no-edit'
alias gd='git difftool'
alias gds='git diff --stat'
alias gl='git log --graph --format="%Cred%h%Creset %s %Cgreen(%cr) %Cblue<%an>"'
alias gm='git difftool -g --dir-diff'
alias gr='git rebase'

# go
export GOPATH=$XDG_CACHE_HOME/go

# fzf
export FZF_DEFAULT_COMMAND="find * \
    \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune  -o -name '*.app' -prune -print \
    -o -type f -print -o -type d -print -o -type l -print 2> /dev/null"
export FZF_DEFAULT_OPTS="-m --reverse --cycle --height=40% \
    --color=hl:1,hl+:1,bg+:0,info:8,border:0,prompt:4,pointer:4,marker:2,spinner:8,header:-1"

# grep
export GREP_COLORS='cx=90:mt=31:fn=32:ln=34:bn=33:se='
alias grep='grep -E --color=auto'

# less
export LESS='-iR --follow-name'
export LESSHISTFILE=$XDG_STATE_HOME/less/history
export PAGER=less

# ls
export LS_COLORS=${(j.:.)=:-'di=34' 'ow=34;40' 'ln=35' {or,mi}'=7;31'
    'ex=91' '*'{'~',.{bak,log,swp,tmp,class,o,pyc,DS_Store,lock}}'=90'}
alias ls='ls --color=auto'

# man
if [[ $EDITOR == nvim ]]; then
  export MANPAGER='nvim +Man!'
fi

# nix
alias nix='noglob nix'
alias np='nix profile'
alias npi='np install'
alias npl='np list'
alias npr='np remove'
alias npu='np upgrade --all'

# ncdu
alias ncdu='ncdu --color off'

# python
export PYTHON_HISTORY=$XDG_STATE_HOME/python/history

# readline
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc

# rg
alias rg='rg -S'
function rgc {
  rg -pC3 $@ | perl -pe "s/(\d+\e\[0m-)(.*)/\$1\e[90m\$2\e[0m/"
}

# run-help
unalias -m run-help
zload run-help

# ssh
alias mbp='ssh mbp'
alias pi='ssh ssh.koholi.net'

# sqlite3
export SQLITE_HISTORY=$XDG_STATE_HOME/sqlite3/history
alias sqlite3='LS_COLORS= sqlite3 --cmd ".mode qbox"'

# up
zload up

# zargs
zload zargs

# zip
export COPYFILE_DISABLE=true

# zmv
zload zmv
alias zmv='noglob zmv'
alias mmv='zmv -W'
