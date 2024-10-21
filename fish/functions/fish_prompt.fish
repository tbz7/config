function fish_prompt
    if [ "$fish_prompt_inactive" = true ]
        set -g fish_prompt_mode inactive
        set -e fish_prompt_inactive
    else
        switch $fish_bind_mode
            case default
                set -g fish_prompt_mode normal
            case paste # pass
            case replace_one
                set -g fish_prompt_mode replace
            case '*'
                set -g fish_prompt_mode $fish_bind_mode
        end
    end

    set -l arrow 
    set -l a 'fish_color_prompt_'$fish_prompt_mode'_a'
    set -l b 'fish_color_prompt_'$fish_prompt_mode'_b'
    set -l a_to_b (string match -rg -- '--background=(\w+)' $$a) (string match -rg -- '(--background=\w+)' $$b)
    set -l b_to_normal (string match -rg -- '--background=(\w+)' $$b) --background=normal

    printf '%s %s %s%s%s %s %s%s%s ' \
        (set_color $$a) \
        (prompt_hostname) \
        (set_color $a_to_b) \
        $arrow \
        (set_color $$b) \
        (prompt_pwd) \
        (set_color $b_to_normal) \
        $arrow \
        (set_color $normal)
end

function fish_prompt_cancel
    set -g fish_prompt_inactive true
    commandline -f repaint cancel-commandline repaint
end

function fish_prompt_execute
    set -g fish_prompt_inactive true
    commandline -f repaint execute
end

function fish_prompt_focus_in --on-event fish_focus_in
    set -e fish_prompt_inactive
    commandline -f repaint
end

function fish_prompt_focus_out --on-event fish_focus_out
    set -g fish_prompt_inactive true
    commandline -f repaint
end

bind -M insert \cc fish_prompt_cancel
bind -M insert \r fish_prompt_execute
