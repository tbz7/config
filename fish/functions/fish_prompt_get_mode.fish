function fish_prompt_get_mode
    if [ "$fish_prompt_inactive" = true ]
        echo inactive
    else
        switch $fish_bind_mode
            case default
                echo normal
            case paste
                # TODO
            case replace_one
                echo replace
            case '*'
                echo $fish_bind_mode
        end
    end
end

function fish_prompt_focus_pre --on-event fish_prompt
    set -e fish_prompt_inactive
end

function fish_prompt_cancel
    set -g fish_prompt_inactive true
    commandline -f repaint cancel-commandline repaint
end

function fish_prompt_execute
    set -g fish_prompt_inactive true
    commandline -f repaint execute
end

function fish_prompt_focus_in --on-event fish_focus_in
    set -e fish_prompt_inactive
    commandline -f repaint
end

function fish_prompt_focus_out --on-event fish_focus_out
    set -g fish_prompt_inactive true
    commandline -f repaint
end

bind -M insert \cc fish_prompt_cancel
bind -M insert \r fish_prompt_execute
