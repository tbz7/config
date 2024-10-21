function fish_set_term_colors --on-event fish_prompt
    set -q term_color_palette || return
    set -l i 0
    for c in $term_color_palette
        echo -n (string replace -r '(..)(..)(..)' '\e]4;'$i';rgb:$1/$2/$3\a' $c)
        set i (math $i + 1)
    end
    echo -n (string replace -r '(..)(..)(..)' '\e]10;rgb:$1/$2/$3\a' $term_color_foreground)
    echo -n (string replace -r '(..)(..)(..)' '\e]11;rgb:$1/$2/$3\a' $term_color_background)
    echo -n (string replace -r '(..)(..)(..)' '\e]12;rgb:$1/$2/$3\a' $term_color_cursor)
    echo -n (string replace -r '(..)(..)(..)' '\e]17;rgb:$1/$2/$3\a' $term_color_selection_background)
    echo -n (string replace -r '(..)(..)(..)' '\e]19;rgb:$1/$2/$3\a' $term_color_selection_foreground)
end
