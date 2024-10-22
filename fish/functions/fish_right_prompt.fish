function fish_right_prompt
    set -l s $status
    set -l arrow 
    set -l mode (fish_prompt_get_mode)
    set -l c 'fish_color_prompt_'$mode'_c'
    set -l error $fish_color_prompt_error
    if [ $mode = inactive ]
        set error $$c
    end
    set -l normal_to_c (string match -rg -- '--background=(\w+)' $$c)
    set -l normal_to_error (string match -rg -- '--background=(\w+)' $error)
    set -l error_to_c $normal_to_c (string match -rg -- '(--background=\w+)' $error)

    if [ $s -ne 0 ]
        printf ' %s%s%s ✗ ' (set_color $normal_to_error) $arrow (set_color $error)
    end

    if command -sq vcs-status
        set -l vcs (string split ':' (vcs-status --notify-pid $fish_pid $PWD 2>/dev/null))
        set -l kind $vcs[1]
        set -l ref $vcs[2]
        set -l dirty $vcs[3]

        if [ -n "$ref" ]
            if [ $s -ne 0 ]
                set_color $error_to_c
            else
                set_color $normal_to_c
            end
            printf '%s%s %s ' $arrow (set_color $$c) $ref
            if [ "$dirty" = true ]
                echo -n '* '
            end
        end
    end

    set_color normal
end

if command -sq vcs-status
    function fish_prompt_update_vcs_status --on-event fish_prompt
        vcs-status --expedite $PWD &>/dev/null
    end

    function fish_prompt_repaint_on_signal --on-signal USR1
        commandline -f repaint
    end
end
