set -g term_color_palette \
    1b1d2b ff757f c3e88d ffc777 82aaff c099ff 86e1fc 828bb8 \
    444a73 e4a4ba c6dec1 e4cdb6 a5bffa c4b6fa a7daf9 c8d3f5
set -g term_color_foreground c8d3f5
set -g term_color_background 222436
set -g term_color_selection_foreground $term_color_foreground
set -g term_color_selection_background 2d3f76
set -g term_color_cursor $term_color_foreground
set -g term_color_cursor_text_color $term_color_background

set -l bg_statusline 1e2030
set -l blue0 3e68d7
set -l blue1 65bcff
set -l blue5 89ddff
set -l comment 636da6
set -l dark3 545c7e
set -l fg_gutter 3b4261
set -l red1 = c53b53

set -g fish_color_autosuggestion $dark3
set -g fish_color_cancel $dark3
set -g fish_color_command $blue1
set -g fish_color_comment $comment --italics
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end $blue5
set -g fish_color_error red
set -g fish_color_escape magenta
set -g fish_color_history_current green --bold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_keyword magenta
set -g fish_color_normal normal
set -g fish_color_operator $blue5
set -g fish_color_option yellow --italics
set -g fish_color_param normal
set -g fish_color_quote green
set -g fish_color_redirection cyan
set -g fish_color_search_match --background=363c58
set -g fish_color_selection --background=$term_color_selection_background
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow --italics
set -g fish_pager_color_prefix normal --bold
set -g fish_pager_color_progress blue
set -g fish_pager_color_selected_background --background=363c58

set -g fish_color_prompt_insert_a black --background=blue
set -g fish_color_prompt_insert_b blue --background=$fg_gutter
set -g fish_color_prompt_insert_c white --background=$bg_statusline
set -g fish_color_prompt_normal_a black --background=green
set -g fish_color_prompt_normal_b green --background=$fg_gutter
set -g fish_color_prompt_normal_c $fish_color_prompt_normal_c
set -g fish_color_prompt_visual_a black --background=magenta
set -g fish_color_prompt_visual_b magenta --background=$fg_gutter
set -g fish_color_prompt_visual_c $fish_color_prompt_normal_c
set -g fish_color_prompt_replace_a black --background=red
set -g fish_color_prompt_replace_b red --background=$fg_gutter
set -g fish_color_prompt_replace_c $fish_color_prompt_normal_c
set -g fish_color_prompt_inactive_a $fg_gutter --background=$bg_statusline --bold
set -g fish_color_prompt_inactive_b $fg_gutter --background=$bg_statusline --bold
set -g fish_color_prompt_inactive_c $fg_gutter --background=$bg_statusline
set -g fish_color_prompt_error black --background=$red1
