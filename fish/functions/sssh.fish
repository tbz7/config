function sssh -a host -a session
    if test -n "$session"
        ssh -t $host shpool attach -f $session
    else
        ssh $host
    end
end
