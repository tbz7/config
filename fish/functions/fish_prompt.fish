function fish_prompt
    echo -en "\e]133;D;$status\a\e]133;A\a"

    set -l arrow 
    set -l mode (prompt_mode)
    set -l a 'fish_color_prompt_'$mode'_a'
    set -l b 'fish_color_prompt_'$mode'_b'
    set -l a_to_b (string match -rg -- '--background=(\w+)' $$a) \
        (string match -rg -- '(--background=\w+)' $$b)
    set -l b_to_normal (string match -rg -- '--background=(\w+)' $$b) --background=normal

    printf '%s %s %s%s%s %s %s%s ' \
        (set_color $$a) (prompt_hostname) (set_color $a_to_b) $arrow \
        (set_color $$b) (prompt_pwd) (set_color $b_to_normal) $arrow

    set_color normal

    echo -en '\e]133;B\a'
end

function __fish_prompt_preexec --on-event fish_preexec
    echo -en '\e]133;C\a'
end
