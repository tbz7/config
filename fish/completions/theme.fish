set -l themes gruvbox iceberg tokyonight

complete -fc theme -a "$themes" \
    -n "not __fish_seen_subcommand_from $themes"

complete -fc theme -a 'dark light' \
    -n '__fish_seen_subcommand_from gruvbox iceberg' \
    -n 'not __fish_seen_subcommand_from dark light'

complete -fc theme -a 'hard soft' \
    -n '__fish_seen_subcommand_from gruvbox' \
    -n '__fish_seen_subcommand_from dark light' \
    -n 'not __fish_seen_subcommand_from hard soft'

complete -fc theme -a 'day moon night storm' \
    -n '__fish_seen_subcommand_from tokyonight' \
    -n 'not __fish_seen_subcommand_from day moon night storm'
