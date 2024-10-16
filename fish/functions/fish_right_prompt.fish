function fish_right_prompt
    set -l arrow 
    # TODO theme, vcs, focus

    if test $status -ne 0
        echo -ns (set_color ff757f) \
            $arrow \
            (set_color 1b1d2b) \
            (set_color -b ff757f) \
            ' ✗ ' \
            (set_color normal)
    end
end
