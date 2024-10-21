function b
    set -l host bee
    if [ -n "$argv[1]" ]
        set host bee-shpool-$argv[1]
    end
    ssh $host
end
