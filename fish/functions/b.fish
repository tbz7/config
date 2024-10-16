function b
    set host bee
    if test -n "$argv[1]"
        set host bee-shpool-$argv[1]
    end
    ssh $host
end
