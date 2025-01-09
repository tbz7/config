function fish_title
    set -l host
    if set -q SSH_TTY || set -q SHPOOL_SESSION_NAME
        set host (string join : (prompt_hostname) $SHPOOL_SESSION_NAME)
    end

    set -l command (status current-command)
    if test "$command" = fish
        set command
    end

    echo (string join ' – ' $host $command)
end
