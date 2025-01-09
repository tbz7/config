function fish_right_prompt
    set -l s $status

    set -q fish_color_error
    or set -l fish_color_error red

    if test $s -ne 0
        echo -n (set_color $fish_color_error) ✘ (set_color normal)
    end

    fish_vcs_prompt ' %s '
end

set -g __fish_git_prompt_color --dim
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showuntrackedfiles yes
