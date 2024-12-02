function b
    if test -n "$argv[1]"
        ssh bee-shpool-$argv[1]
    else
        ssh bee
    end
end
