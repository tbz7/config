function sssh -a host -a session
    if test -n "$session"
        ssh $host-shpool-$session
    else
        ssh $host
    end
end
