# moon
set -l bg 222436
set -l bg_statusline 1e2030
set -l bg_visual 2d3f76
set -l black 1b1d2b
set -l blue 82aaff
set -l blue1 65bcff
set -l blue5 89ddff
set -l blue_bright 9ab8ff
set -l comment 636da6
set -l cyan 86e1fc
set -l cyan_bright b2ebff
set -l dark3 545c7e
set -l fg c8d3f5
set -l fg_dark 828bb8
set -l fg_gutter 3b4261
set -l green c3e88d
set -l green_bright c7fb6d
set -l magenta c099ff
set -l magenta_bright caabff
set -l PmenuSel_bg 363c58
set -l red ff757f
set -l red1 c53b53
set -l red_bright ff8d94
set -l terminal_black 444a73
set -l yellow ffc777
set -l yellow_bright ffd8ab
set -g helix_theme tokyonight_moon

switch "$argv[1]"
    case day
        set bg e1e2e7
        set bg_statusline d0d5e3
        set bg_visual b7c1e3
        set black b4b5b9
        set blue 2e7de9
        set blue1 188092
        set blue5 006a83
        set blue_bright 358aff
        set comment 848cb5
        set cyan 007197
        set cyan_bright 007ea8
        set dark3 8990b3
        set fg 3760bf
        set fg_dark 6172b0
        set fg_gutter a8aecb
        set green 587539
        set green_bright 5c8524
        set magenta 9854f1
        set magenta_bright a463ff
        set PmenuSel_bg b3b8d1
        set red f52a65
        set red1 c64343
        set red_bright ff4774
        set terminal_black a1a6c5
        set yellow 8c6c3e
        set yellow_bright a27629
        set helix_theme tokyonight_day
    case night
        set bg 1a1b26
        set bg_statusline 16161e
        set bg_visual 283457
        set black 15161e
        set blue 7aa2f7
        set blue1 2ac3de
        set blue5 89ddff
        set blue_bright 8db0ff
        set comment 565f89
        set cyan 7dcfff
        set cyan_bright a4daff
        set dark3 545c7e
        set fg c0caf5
        set fg_dark a9b1d6
        set fg_gutter 3b4261
        set green 9ece6a
        set green_bright 9fe044
        set magenta bb9af7
        set magenta_bright c7a9ff
        set PmenuSel_bg 343a55
        set red f7768e
        set red1 db4b4b
        set red_bright ff899d
        set terminal_black 414868
        set yellow e0af68
        set yellow_bright faba4a
        set helix_theme tokyonight
    case storm
        set bg 24283b
        set bg_statusline 1f2335
        set bg_visual 2e3c64
        set black 1d202f
        set blue 7aa2f7
        set blue1 2ac3de
        set blue5 89ddff
        set blue_bright 8db0ff
        set comment 565f89
        set cyan 7dcfff
        set cyan_bright a4daff
        set dark3 545c7e
        set fg c0caf5
        set fg_dark a9b1d6
        set fg_gutter 3b4261
        set green 9ece6a
        set green_bright 9fe044
        set magenta bb9af7
        set magenta_bright c7a9ff
        set PmenuSel_bg 363d59
        set red f7768e
        set red1 db4b4b
        set red_bright ff899d
        set terminal_black 414868
        set yellow e0af68
        set yellow_bright faba4a
        set helix_theme tokyonight_storm
end

set -g term_color_palette \
    $black $red $green $yellow $blue $magenta $cyan $fg_dark \
    $terminal_black $red_bright $green_bright $yellow_bright $blue_bright $magenta_bright $cyan_bright $fg
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
set -g fish_color_prompt_normal_c $fish_color_prompt_insert_c
set -g fish_color_prompt_visual_a $terminal_black --background=$magenta
set -g fish_color_prompt_visual_b $magenta --background=$fg_gutter
set -g fish_color_prompt_visual_c $fish_color_prompt_insert_c
set -g fish_color_prompt_replace_a $terminal_black --background=$red
set -g fish_color_prompt_replace_b $red --background=$fg_gutter
set -g fish_color_prompt_replace_c $fish_color_prompt_insert_c
set -g fish_color_prompt_inactive_a $fg_gutter --background=$bg_statusline --bold
set -g fish_color_prompt_inactive_b $fg_gutter --background=$bg_statusline --bold
set -g fish_color_prompt_inactive_c $fg_gutter --background=$bg_statusline
