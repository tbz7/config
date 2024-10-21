function fish_right_prompt
    set -l s $status
    set -l arrow 
    set -l c 'fish_color_prompt_'$fish_prompt_mode'_c'

    set -l error $fish_color_prompt_error
    if [ $fish_prompt_mode = inactive ]
        set error $$c
    end
    set -l normal_to_error (string match -rg -- '--background=(\w+)' $error)

    if [ $s -ne 0 ]
        printf ' %s%s%s ✗ %s' \
            (set_color $normal_to_error) \
            $arrow \
            (set_color $error) \
            (set_color normal)
    end

    # TODO
    set_color $$c
    fish_vcs_prompt
    set_color normal
end
