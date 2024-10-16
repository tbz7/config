set -l ansi \
    '#1b1d2b' '#ff757f' '#c3e88d' '#ffc777' '#82aaff' '#c099ff' '#86e1fc' '#828bb8' \
    '#444a73' '#e4a4ba' '#c6dec1' '#e4cdb6' '#a5bffa' '#c4b6fa' '#a7daf9' '#c8d3f5'
set -l fg '#c8d3f5'
set -l bg '#222436'
set -l cursor '#c8d3f5'
set -l select_fg '#c8d3f5'
set -l select_bg '#2d3f76'

set -l main \
    afg='#1b1d2b' abg='#82aaff' bfg='#82aaff' bbg='#3b4261' \
    cfg='#828bb8' cbg='#1e2030' efg='#1b1d2b' ebg='#ff757f'
set -l vicmd \
    afg='#1b1d2b' abg='#c3e88d' bfg='#c3e88d' bbg='#3b4261' \
    cfg='#828bb8' cbg='#1e2030' efg='#1b1d2b' ebg='#ff757f'
set -l inactive \
    afg='#3b4261' abg='#1e2030' bfg='#3b4261' bbg='#1e2030' \
    cfg='#3b4261' cbg='#1e2030' efg='#3b4261' ebg='#1e2030'

set -l i 0
for c in $ansi
    echo -n (string replace -r '#(..)(..)(..)' '\e]4;'$i';rgb:$1/$2/$3\a' $c)
    set i (math $i + 1)
end
echo -n (string replace -r '#(..)(..)(..)' '\e]10;rgb:$1/$2/$3\a' $fg)
echo -n (string replace -r '#(..)(..)(..)' '\e]11;rgb:$1/$2/$3\a' $bg)
echo -n (string replace -r '#(..)(..)(..)' '\e]12;rgb:$1/$2/$3\a' $cursor)
echo -n (string replace -r '#(..)(..)(..)' '\e]17;rgb:$1/$2/$3\a' $select_fg)
echo -n (string replace -r '#(..)(..)(..)' '\e]19;rgb:$1/$2/$3\a' $select_bg)
