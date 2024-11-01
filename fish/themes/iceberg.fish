# dark
set -l blue 84a0c6
set -l comment_fg 6b7089
set -l cursorline_bg 1e2132
set -l green b4be82
set -l lblue 89b8c2
set -l normal_bg 161821
set -l normal_fg c6c8d1
set -l orange e2a478
set -l pmenu_bg 3d425b
set -l pmenusel_bg 5b6389
set -l purple a093c7
set -l red e27878
set -l statusline_bg 818596
set -l statusline_fg 17171b
set -l statuslinenc_bg 0f1117
set -l statuslinenc_fg 3e445e
set -l visual_bg 272c42
set -l xline_gradient_bg 2e313f
set -g helix_theme iceberg-dark

if [ "$argv[1]" = light ]
    set blue 2d539e
    set comment_fg 8389a3
    set cursorline_bg dcdfe7
    set cursorlinenr_bg cad0de
    set green 668e3d
    set lblue 3f83a6
    set normal_bg e8e9ec
    set normal_fg 33374c
    set orange c57339
    set pmenusel_bg a7b2cd
    set purple 7759b4
    set red cc517a
    set statusline_bg 757ca3
    set statuslinenc_fg 8b98b6
    set visual_bg c9cdd7
    set xline_gradient_bg 9fa6c0
    set helix_theme iceberg-light

    set -g term_color_palette \
        $cursorline_bg $red $green $orange $blue $purple $lblue $normal_fg \
        $comment_fg cc3768 598030 b6662d 22478e 6845ad 327698 262a3f

    set -g fish_color_autosuggestion $cursorlinenr_bg
    set -g fish_color_cancel $cursorlinenr_bg

    set -g fish_color_prompt_insert_a $normal_bg --background=$statusline_bg
    set -g fish_color_prompt_insert_b $normal_bg --background=$xline_gradient_bg
    set -g fish_color_prompt_insert_c $statuslinenc_fg --background=$cursorlinenr_bg
else
    set -g term_color_palette \
        $cursorline_bg $red $green $orange $blue $purple $lblue $normal_fg \
        $comment_fg e98989 c0ca8e e9b189 91acd1 ada0d3 95c4ce d2d4de

    set -g fish_color_autosuggestion $pmenu_bg
    set -g fish_color_cancel $pmenu_bg

    set -g fish_color_prompt_insert_a $statusline_fg --background=$statusline_bg
    set -g fish_color_prompt_insert_b $comment_fg --background=$xline_gradient_bg
    set -g fish_color_prompt_insert_c $statuslinenc_fg --background=$statuslinenc_bg
end

set -g term_color_foreground $normal_fg
set -g term_color_background $normal_bg
set -g term_color_selection_foreground $normal_fg
set -g term_color_selection_background $visual_bg
set -g term_color_cursor $normal_fg
set -g term_color_cursor_text_color $normal_bg

set -g fish_color_command $blue
set -g fish_color_comment $comment_fg
set -g fish_color_cwd $green
set -g fish_color_cwd_root $red
set -g fish_color_end $blue
set -g fish_color_error $red
set -g fish_color_escape $green
set -g fish_color_history_current $green --bold
set -g fish_color_host $normal_fg
set -g fish_color_host_remote $yellow
set -g fish_color_keyword $blue
set -g fish_color_normal $normal_fg
set -g fish_color_operator $blue
set -g fish_color_option $lblue
set -g fish_color_param $normal_fg
set -g fish_color_quote $lblue
set -g fish_color_redirection $lblue
set -g fish_color_search_match --background=$pmenusel_bg
set -g fish_color_selection --background=$visual_bg
set -g fish_color_status $red
set -g fish_color_user $green
set -g fish_color_valid_path --underline

set -g fish_pager_color_completion $normal_fg
set -g fish_pager_color_description $green
set -g fish_pager_color_prefix $normal_fg --bold
set -g fish_pager_color_progress $blue
set -g fish_pager_color_selected_background --background=$pmenusel_bg

set -g fish_color_prompt_normal_a $normal_bg --background=$blue
set -g fish_color_prompt_normal_b $fish_color_prompt_insert_b
set -g fish_color_prompt_normal_c $fish_color_prompt_insert_c
set -g fish_color_prompt_visual_a $normal_bg --background=$green
set -g fish_color_prompt_visual_b $fish_color_prompt_insert_b
set -g fish_color_prompt_visual_c $fish_color_prompt_insert_c
set -g fish_color_prompt_replace_a $normal_bg --background=$orange
set -g fish_color_prompt_replace_b $fish_color_prompt_insert_b
set -g fish_color_prompt_replace_c $fish_color_prompt_insert_c
set -g fish_color_prompt_inactive_a $fish_color_prompt_insert_c
set -g fish_color_prompt_inactive_b $fish_color_prompt_insert_a
set -g fish_color_prompt_inactive_c $fish_color_prompt_insert_c
set -g fish_color_prompt_error $normal_bg --background=$red
