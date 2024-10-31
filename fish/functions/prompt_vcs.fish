function prompt_vcs --description 'VCS info for the prompt'
    command -q vcs-status || return 1

    set -l vcs (string split ':' (vcs-status --notify-pid $fish_pid $PWD 2>/dev/null))

    echo $vcs[2] (string replace -f true '*' $vcs[3])
end

function __prompt_vcs_pre_prompt --on-event fish_prompt
    command -q vcs-status && vcs-status --expedite $PWD &>/dev/null
end

function __prompt_vcs_on_signal --on-signal USR1
    emit prompt_vcs_updated
end
