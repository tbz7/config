status is-interactive || return

set -g fish_color_autosuggestion brblack --dim
set -g fish_color_cancel brblack
set -g fish_color_command brblue
set -g fish_color_comment brblack --italics
set -g fish_color_cwd blue
set -g fish_color_cwd_root red
set -g fish_color_end cyan
set -g fish_color_error brred
set -g fish_color_escape yellow
set -g fish_color_history_current --bold
set -g fish_color_host brgreen
set -g fish_color_host_remote yellow
set -g fish_color_keyword magenta
set -g fish_color_normal normal
set -g fish_color_operator cyan
set -g fish_color_option yellow
set -g fish_color_param normal
set -g fish_color_quote brgreen
set -g fish_color_redirection cyan
set -g fish_color_search_match --background=black
set -g fish_color_selection --background=brblack
set -g fish_color_status red
set -g fish_color_user yellow
set -g fish_color_valid_path --underline
set -g fish_cursor_insert line blink
set -g fish_cursor_visual underscore
set -g fish_greeting
set -g fish_pager_color_completion
set -g fish_pager_color_description cyan
set -g fish_pager_color_prefix --bold
set -g fish_pager_color_progress cyan
set -g fish_pager_color_selected_background --background=black

functions -e fish_mode_prompt
