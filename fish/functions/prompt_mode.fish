function prompt_mode
    if $__prompt_mode_inactive
        echo inactive
    else
        string replace default normal (string replace _one '' $fish_bind_mode)
    end
end

set -g __prompt_mode_inactive false

function __prompt_mode_pre_prompt --on-event fish_prompt
    set __prompt_mode_inactive false
end

function __prompt_mode_focus_in --on-event fish_focus_in
    set __prompt_mode_inactive false
    commandline -f repaint
end

function __prompt_mode_focus_out --on-event fish_focus_out
    set __prompt_mode_inactive true
    commandline -f repaint
end

set -l execute 'set __prompt_mode_inactive true; commandline -f repaint execute'
bind -M insert enter $execute
bind -m insert enter $execute
bind -M replace -m insert enter "$execute repaint-mode"
