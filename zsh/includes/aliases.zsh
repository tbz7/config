alias cdd='cd ~/Desktop'
alias cdf='() { cd $1:A:h }'
alias cdot="cd $ZDOTDIR:h:q"
alias cdotl="cd $ZDOTDIR_LOCAL:h:q"

alias clean='() { find ${1-.} -name .DS_Store -print -delete }'

alias e='$EDITOR'

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

alias h='hg status'
alias har='hg addremove'
alias hc='hg checkout'
alias hcm 'hg cm'
alias hcma='hg amend'
alias hd='hg vimdiff'
alias hds='hg diff --stat'
alias hm='hg meld'
alias hm1='hg meld -r .~1'

alias mmv='zmv -W'

alias rgc='() { rg -pC3 $@ | perl -pe "s/(\d+\e\[0m-)(.*)/\$1\e[90m\$2\e[0m/" }'

alias tm="echo -n '\\e]1337;SetUserVar=process-name=dG11eA==\\a';
    tmux new-session -A -s main;
    echo -n '\\e]1337;SetUserVar=process-name=\\a'"
