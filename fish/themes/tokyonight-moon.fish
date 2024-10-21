set -l bg 222436
set -l bg_statusline 1e2030
set -l bg_visual 2d3f76
set -l black 1b1d2b
set -l blue 82aaff
set -l blue1 65bcff
set -l blue5 89ddff
set -l comment 636da6
set -l cyan 86e1fc
set -l dark3 545c7e
set -l fg c8d3f5
set -l fg_dark 828bb8
set -l fg_gutter 3b4261
set -l green c3e88d
set -l magenta c099ff
set -l PmenuSel_bg = 363c58
set -l red ff757f
set -l red1 = c53b53
set -l terminal_black 444a73
set -l yellow ffc777

set -g term_color_palette \
    $black $red $green $yellow $blue $magenta $cyan $fg_dark \
    $terminal_black e4a4ba c6dec1 e4cdb6 a5bffa c4b6fa a7daf9 $fg
set -g term_color_foreground $fg
set -g term_color_background $bg
set -g term_color_selection_foreground $fg
set -g term_color_selection_background $bg_visual
set -g term_color_cursor $fg
set -g term_color_cursor_text_color $bg

set -g fish_color_autosuggestion $dark3
set -g fish_color_cancel $dark3
set -g fish_color_command $blue1
set -g fish_color_comment $comment --italics
set -g fish_color_cwd $green
set -g fish_color_cwd_root $red
set -g fish_color_end $blue5
set -g fish_color_error $red
set -g fish_color_escape $magenta
set -g fish_color_history_current $green --bold
set -g fish_color_host $fg
set -g fish_color_host_remote $yellow
set -g fish_color_keyword $magenta
set -g fish_color_normal $fg
set -g fish_color_operator $blue5
set -g fish_color_option $yellow --italics
set -g fish_color_param $fg
set -g fish_color_quote $green
set -g fish_color_redirection $cyan
set -g fish_color_search_match --background=$PmenuSel_bg
set -g fish_color_selection --background=$bg_visual
set -g fish_color_status $red
set -g fish_color_user $green
set -g fish_color_valid_path --underline

set -g fish_pager_color_completion $fg
set -g fish_pager_color_description $yellow --italics
set -g fish_pager_color_prefix $fg --bold
set -g fish_pager_color_progress $blue
set -g fish_pager_color_selected_background --background=$PmenuSel_bg

set -g fish_color_prompt_insert_a $terminal_black --background=$blue
set -g fish_color_prompt_insert_b $blue --background=$fg_gutter
set -g fish_color_prompt_insert_c $fg_dark --background=$bg_statusline
set -g fish_color_prompt_normal_a $terminal_black --background=$green
set -g fish_color_prompt_normal_b $green --background=$fg_gutter
set -g fish_color_prompt_normal_c $fish_color_prompt_normal_c
set -g fish_color_prompt_visual_a $terminal_black --background=$magenta
set -g fish_color_prompt_visual_b $magenta --background=$fg_gutter
set -g fish_color_prompt_visual_c $fish_color_prompt_normal_c
set -g fish_color_prompt_replace_a $terminal_black --background=$red
set -g fish_color_prompt_replace_b $red --background=$fg_gutter
set -g fish_color_prompt_replace_c $fish_color_prompt_normal_c
set -g fish_color_prompt_inactive_a $fg_gutter --background=$bg_statusline --bold
set -g fish_color_prompt_inactive_b $fg_gutter --background=$bg_statusline --bold
set -g fish_color_prompt_inactive_c $fg_gutter --background=$bg_statusline
set -g fish_color_prompt_error $black --background=$red1
