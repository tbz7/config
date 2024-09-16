zload compinit
zload zsh/complist

zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zstyle -e ':completion:*' list-colors 'reply=(${(s.:.)LS_COLORS})'
zstyle ':completion:*' matcher-list 'm:{a-z-_}={A-Z_-}'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on

bindkey -M menuselect '\e[Z' reverse-menu-complete

compinit -C -d $XDG_CACHE_HOME/zsh/zcompdump

function compreinit {
  rm -rf $XDG_CACHE_HOME/zsh/{zcompdump,zcompcache}
  compinit -C -d $XDG_CACHE_HOME/zsh/zcompdump
}
