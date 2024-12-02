function fish_right_prompt
    set -l s $status
    set -l arrow 
    set -l mode (prompt_mode)
    set -l c 'fish_color_prompt_'$mode'_c'
    set -l normal_to_c (string match -rg -- '--background=(\w+)' $$c)

    if [ $s -ne 0 ] && [ "$mode" != inactive ]
        set_color $fish_color_error
        echo -n ' '
    end

    set -l vcs (prompt_vcs)
    if test -n "$vcs"
        printf '%s%s%s %s ' (set_color $normal_to_c) $arrow (set_color $$c) $vcs
    end

    set_color normal
end

function __fish_right_prompt_vcs_updated --on-event prompt_vcs_updated
    commandline -f repaint
end
