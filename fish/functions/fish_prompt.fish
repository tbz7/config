function fish_prompt
    set -l s $status

    test -n "$SSH_TTY"
    and echo -n (set_color brgreen)(prompt_hostname)(set_color normal)' '

    test -n "$SHPOOL_SESSION_NAME"
    and echo -n (set_color cyan)"[$SHPOOL_SESSION_NAME]"(set_color normal)' '

    echo -n (set_color blue)(prompt_pwd -D 3)(set_color normal)

    fish_vcs_prompt ' %s'

    echo

    if test $s -ne 0
        set_color brred
    else
        set_color brblue
    end
    echo ❯(set_color normal)' '

    function __fish_prompt_blank_line --on-event fish_prompt
        echo
    end
end

set -g __fish_git_prompt_color --dim
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showuntrackedfiles yes
