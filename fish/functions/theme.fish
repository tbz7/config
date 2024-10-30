function theme
    if [ -z "$argv[1]" ]
        echo "Usage: theme THEME args..." >&2
        return 1
    else if ! [ -f $__fish_config_dir/themes/$argv[1].fish ]
        echo "Invalid theme: $argv[1]" >&2
        return 1
    end
    source $__fish_config_dir/themes/$argv[1].fish $argv[2..-1]
end
