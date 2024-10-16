function fish_prompt
    set -l arrow 

    # TODO theme colors, mode, focus

    if [ -z "$fish_prompt_inactive" ]
        echo -ns (set_color 1b1d2b) \
            (set_color -b 82aaff) \
            " $(prompt_hostname) " \
            (set_color 82aaff) \
            (set_color -b 3b4261) $arrow \
            (set_color 82aaff) \
            " $(prompt_pwd) " \
            (set_color normal) \
            (set_color 3b4261) \
            "$arrow " \
            (set_color normal)
    else
        echo -ns (set_color 3b4261) \
            (set_color -b 1e2030) \
            " $(prompt_hostname) " \
            (set_color 1e2030) \
            (set_color -b 1e2030) $arrow \
            (set_color 3b4261) \
            " $(prompt_pwd) " \
            (set_color normal) \
            (set_color 1e2030) \
            "$arrow " \
            (set_color normal)
        set -e fish_prompt_inactive
    end
end

function fish_prompt_inactive
    set -g fish_prompt_inactive true
    commandline -f repaint execute
end

function fish_prompt_cancel
    set -g fish_prompt_inactive true
    commandline -f repaint cancel-commandline repaint-mode
end

bind -M insert \r fish_prompt_inactive
bind -M insert \cc fish_prompt_cancel

function fish_mode_prompt
end
