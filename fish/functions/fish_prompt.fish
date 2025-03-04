function fish_prompt
    set -l parts

    set -q SSH_TTY
    and set -a parts (set_color brgreen)(prompt_hostname)

    set -a parts (set_color cyan)'['$SHPOOL_SESSION_NAME']'
    set -a parts (set_color blue)(prompt_pwd -D 3)
    set -a parts (fish_vcs_prompt '%s')

    string join (set_color normal)' ' $parts

    echo (set_color brblue)'❯'(set_color normal)' '

    function __fish_prompt_before --on-event fish_prompt
        if test $status -ne 0
            echo -n (set_color brred)'✘'
        end
        echo
    end
end

set -g __fish_git_prompt_color --dim
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showuntrackedfiles yes
