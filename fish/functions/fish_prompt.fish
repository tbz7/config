function fish_prompt
    set -g fish_prompt_mode $fish_bind_mode
    switch $fish_prompt_mode
        case replace_one
            set fish_prompt_mode replace
        case default
            set fish_prompt_mode normal
    end
    if [ "$fish_prompt_inactive" = true ]
        set fish_prompt_mode inactive
        set -e fish_prompt_inactive
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

function fish_prompt_inactive
    set -g fish_prompt_inactive true
    commandline -f repaint execute
end

function fish_prompt_inactive2 --on-event fish_focus_out
    set -g fish_prompt_inactive true
    commandline -f repaint
end

function fish_prompt_active --on-event fish_focus_in
    set -e fish_prompt_inactive
    commandline -f repaint
end

function fish_enable_focus --on-event fish_prompt
    echo -en '\e[?1004h'
end

function fish_disable_focus --on-event fish_preexec
    echo -en '\e[?1004l'
end

function fish_prompt_cancel
    set -g fish_prompt_inactive true
    commandline -f repaint cancel-commandline repaint-mode
end

bind -M insert \r fish_prompt_inactive
bind -M insert \cc fish_prompt_cancel

bind \e\[O 'emit fish_focus_out'
bind -M insert \e\[O 'emit fish_focus_out'
bind -M visual \e\[O 'emit fish_focus_out'
