function send-job-to-foreground
    if test -z "$(commandline)"
        commandline fg
        __prompt_mode_focus_out
        commandline -f execute
    else
        echo -n \a
    end
end
