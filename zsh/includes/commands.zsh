# cd
alias cdd='cd ~/Desktop'
alias cdf='() { cd $1:A:h }'
alias cdot="cd $ZDOTDIR:h:q"
alias cdotl="cd $ZDOTDIR_LOCAL:h:q"

# clean
function clean {
  find ${1-.} -name .DS_Store -print -delete
}

# clip
function clip {
  echo -n "\e]52;c;$(base64 | tr -d '\r\n')\e\\"
}

# diff
if [[ -n $commands[colordiff] ]]; then
  alias diff='colordiff'
fi

# editor
export EDITOR=${${commands[(i)nvim]:-${commands[(i)vim]:-vi}}}
alias e="$EDITOR"

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

# fzf
export FZF_DEFAULT_COMMAND="find * \
    \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
    -o -name '*.app' -prune -print \
    -o -type f -print -o -type d -print -o -type l -print 2> /dev/null"
export FZF_DEFAULT_OPTS="-m --reverse --cycle --height=40% \
    --color=hl:1,hl+:1,bg+:0,info:8,border:0,prompt:4,pointer:4 \
    --color=marker:2,spinner:8,header:-1"

# grep
export GREP_COLORS='cx=90:mt=31:fn=32:ln=34:bn=33:se='
alias grep="${commands[ggrep]+g}grep -E --color=auto"

# hg
alias h='hg status'
alias har='hg addremove'
alias hc='hg checkout'
alias hcm='hg cm'
alias hcma='hg amend'
alias hd='hg d'
alias hd1='hg d -r .~1'
alias hds='hg diff --stat'
alias hm='hg meld'
alias hm1='hg meld -r .~1'

# less
export LESS='-iR --follow-name'
export LESSHISTFILE=~/.local/state/less/history
export PAGER='less'

# ls
export LS_COLORS=${(j.:.)=:-'di=34' 'ow=34;40' 'ln=35' {or,mi}'=7;31'
    'ex=91' '*'{'~',.{bak,log,swp,tmp,class,o,pyc,DS_Store}}'=90'}
alias ls="${commands[gls]+g}ls --color=auto"

# man
if [[ -n $commands[nvim] ]]; then
  export MANPAGER='nvim +Man!'
fi

# ncdu
alias ncdu='ncdu --color off'

# rg
alias rg='rg -S'
function rgc {
  rg -pC3 $@ | perl -pe "s/(\d+\e\[0m-)(.*)/\$1\e[90m\$2\e[0m/"
}

# vim
alias vim="vim -u $ZDOTDIR:h/vim/vimrc"

# zip
export COPYFILE_DISABLE=true

# zmv
alias zmv='noglob zmv'
alias mmv='zmv -W'
