function clean
    set -l dir $argv[1] .
    find $dir[1] -name .DS_Store -print -delete
end
