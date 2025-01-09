complete theme -s l -l list -d 'List available themes'
complete theme -s U -l universal -d 'Save the given theme as universal variables'

set -l themes (theme -l)

complete theme -f
complete theme -a "$themes" -n "not __fish_seen_subcommand_from $themes"
