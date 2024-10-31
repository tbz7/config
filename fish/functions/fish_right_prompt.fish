function fish_right_prompt
    set -l s $status
    set -l arrow 
    set -l mode (prompt_mode)
    set -l c 'fish_color_prompt_'$mode'_c'
    set -l error $fish_color_prompt_error
    if [ $mode = inactive ]
        set error $$c
    end
    set -l normal_to_c (string match -rg -- '--background=(\w+)' $$c)
    set -l normal_to_error (string match -rg -- '--background=(\w+)' $error)
    set -l error_to_c $normal_to_c (string match -rg -- '(--background=\w+)' $error)

    if [ $s -ne 0 ]
        printf ' %s%s%s ✗ %s' \
            (set_color $normal_to_error) $arrow (set_color $error) (set_color $error_to_c)
    else
        set_color $normal_to_c
    end

    set -l vcs (prompt_vcs)
    if [ -n "$vcs" ]
        printf '%s%s %s ' $arrow (set_color $$c) $vcs
    end

    set_color normal
end

function __fish_right_prompt_vcs_updated --on-event prompt_vcs_updated
    commandline -f repaint
end
