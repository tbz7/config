setopt extendedglob
setopt extendedhistory
setopt globstarshort
setopt histignorealldups
setopt histignorespace
setopt histverify
setopt interactivecomments
setopt sharehistory

HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=10000
ZLE_RPROMPT_INDENT=0
ZLE_SPACE_SUFFIX_CHARS='&|'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
declare -gA ZSH_HIGHLIGHT_STYLES=(comment 'fg=8')
