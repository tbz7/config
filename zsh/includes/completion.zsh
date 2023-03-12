autoload -U compinit
zmodload zsh/complist

zstyle ':completion:*' cache-path ~/.cache/zsh/zcompcache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # dep: commands.zsh
zstyle ':completion:*' matcher-list 'm:{a-z-_}={A-Z_-}'
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on

bindkey -M menuselect $terminfo[kcbt] reverse-menu-complete

compinit -C -d ~/.cache/zsh/zcompdump
