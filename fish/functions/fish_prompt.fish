function fish_prompt
    set -l arrow 
    set -l mode (prompt_mode)
    set -l a 'fish_color_prompt_'$mode'_a'
    set -l b 'fish_color_prompt_'$mode'_b'
    set -l a_to_b \
        (string match -rg -- '--background=(\w+)' $$a) \
        (string match -rg -- '(--background=\w+)' $$b)
    set -l b_to_normal --background=normal \
        (string match -rg -- '--background=(\w+)' $$b)

    printf '%s %s %s%s%s %s %s%s %s\e]133;B\a' \
        (set_color $$a) (prompt_hostname) (set_color $a_to_b) $arrow \
        (set_color $$b) (prompt_pwd) (set_color $b_to_normal) $arrow (set_color normal)
end
