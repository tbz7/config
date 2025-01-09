status is-interactive || return

function __term_colors_update \
    -v fish_color_term_foreground \
    -v fish_color_term_background \
    -v fish_color_term_cursor_background \
    -v fish_color_term_selection_background \
    -v fish_color_term_selection_foreground \
    -v fish_color_term_black \
    -v fish_color_term_red \
    -v fish_color_term_green \
    -v fish_color_term_yellow \
    -v fish_color_term_blue \
    -v fish_color_term_magenta \
    -v fish_color_term_cyan \
    -v fish_color_term_white \
    -v fish_color_term_bright_black \
    -v fish_color_term_bright_red \
    -v fish_color_term_bright_green \
    -v fish_color_term_bright_yellow \
    -v fish_color_term_bright_blue \
    -v fish_color_term_bright_magenta \
    -v fish_color_term_bright_cyan \
    -v fish_color_term_bright_white

    __term_colors_set
    __term_colors_apply
    commandline -f repaint
end

function __term_colors_set
    set -g __term_color_seqs

    __term_color_add 10 $fish_color_term_foreground
    __term_color_add 11 $fish_color_term_background
    __term_color_add 12 $fish_color_term_cursor_background
    __term_color_add 17 $fish_color_term_selection_background
    __term_color_add 19 $fish_color_term_selection_foreground

    __term_color_add '4;0' $fish_color_term_black
    __term_color_add '4;1' $fish_color_term_red
    __term_color_add '4;2' $fish_color_term_green
    __term_color_add '4;3' $fish_color_term_yellow
    __term_color_add '4;4' $fish_color_term_blue
    __term_color_add '4;5' $fish_color_term_magenta
    __term_color_add '4;6' $fish_color_term_cyan
    __term_color_add '4;7' $fish_color_term_white
    __term_color_add '4;8' $fish_color_term_bright_black
    __term_color_add '4;9' $fish_color_term_bright_red
    __term_color_add '4;10' $fish_color_term_bright_green
    __term_color_add '4;11' $fish_color_term_bright_yellow
    __term_color_add '4;12' $fish_color_term_bright_blue
    __term_color_add '4;13' $fish_color_term_bright_magenta
    __term_color_add '4;14' $fish_color_term_bright_cyan
    __term_color_add '4;15' $fish_color_term_bright_white
end

function __term_color_add -a code -a hex
    string match -qr '^[[:xdigit:]]{6}$' $hex
    and set -a __term_color_seqs (printf '\e]%s;rgb:%s%s/%s%s/%s%s\a' $code (string split '' $hex))
end

function __term_colors_apply --on-event fish_prompt
    echo -ns $__term_color_seqs
end

__term_colors_set
