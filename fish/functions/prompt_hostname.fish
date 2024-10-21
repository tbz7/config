function prompt_hostname --description 'short hostname for the prompt'
    if string match -q '*-shpool-*' "$SHPOOL_SESSION_NAME"
        string replace -- -shpool "" $SHPOOL_SESSION_NAME
    else
        string replace -r -- '\..*' '' $hostname
    end
end
