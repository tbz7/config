set -l themes gruvbox iceberg tokyonight

complete theme -f
complete theme -s U -l universal -d 'Save the given theme as universal variables'
complete theme -a "$themes" -n "not __fish_seen_subcommand_from $themes"
