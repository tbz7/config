function sssh -a host -a session
    ssh (string join '' -- $host '-shpool-'$session)
end
