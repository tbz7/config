status is-interactive || return

set -gx --path LS_COLORS di=34 ow=34\;40 ln=35 {or,mi}=7\;31 ex=91 \
    \*{~,.{bak,log,swp,tmp,class,o,pyc,DS_Store,lock}}=90

function __theme_load --on-variable fish_theme
    if test -z "$fish_theme"
        set -U fish_theme tokyonight moon
    else if ! test -f $__fish_config_dir/themes/$fish_theme[1].fish
        echo "Invalid theme: $fish_theme[1]" >&2
        set fish_theme tokyonight moon
    end

    source $__fish_config_dir/themes/$fish_theme[1].fish $fish_theme[2..-1]

    __theme_set_term_palette
end

function __theme_set_term_palette --on-event fish_prompt
    set -l i 0
    for c in $term_color_palette
        echo -n (string replace -r '(..)(..)(..)' "\e]4;$i;rgb:\$1/\$2/\$3\a" $c)
        set i (math $i + 1)
    end
    echo -n (string replace -r '(..)(..)(..)' "\e]10;rgb:\$1/\$2/\$3\a" $term_color_foreground)
    echo -n (string replace -r '(..)(..)(..)' "\e]11;rgb:\$1/\$2/\$3\a" $term_color_background)
    echo -n (string replace -r '(..)(..)(..)' "\e]12;rgb:\$1/\$2/\$3\a" $term_color_cursor)
    echo -n (string replace -r '(..)(..)(..)' "\e]17;rgb:\$1/\$2/\$3\a" $term_color_selection_background)
    echo -n (string replace -r '(..)(..)(..)' "\e]19;rgb:\$1/\$2/\$3\a" $term_color_selection_foreground)
end

__theme_load

set -l themes gruvbox iceberg tokyonight
complete -fc set -a "$themes" \
    -n '__fish_seen_subcommand_from fish_theme' \
    -n "not __fish_seen_subcommand_from $themes"
complete -fc set -a 'dark light' \
    -n '__fish_seen_subcommand_from fish_theme' \
    -n '__fish_seen_subcommand_from gruvbox iceberg' \
    -n 'not __fish_seen_subcommand_from dark light'
complete -fc set -a 'hard soft' \
    -n '__fish_seen_subcommand_from fish_theme' \
    -n '__fish_seen_subcommand_from gruvbox' \
    -n '__fish_seen_subcommand_from dark light' \
    -n 'not __fish_seen_subcommand_from hard soft'
complete -fc set -a 'day moon night storm' \
    -n '__fish_seen_subcommand_from fish_theme' \
    -n '__fish_seen_subcommand_from tokyonight' \
    -n 'not __fish_seen_subcommand_from day moon night storm'
