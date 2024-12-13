function fish_prompt
    set -q fish_color_host
    or set -l fish_color_host green

    set -q fish_color_cwd
    or set -l fish_color_cwd blue

    echo -ns \
        (set_color $fish_color_host) (prompt_hostname) (set_color normal) : \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color brblue) ' ❯ ' (set_color normal)
end
