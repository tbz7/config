# dark
set -l bg0 282828
set -l bg1 3c3836
set -l bg2 504945
set -l bg3 665c54
set -l bg4 7c6f64
set -l fg0 fbf1c7
set -l fg1 ebdbb2
set -l fg2 d5c4a1
set -l fg3 bdae93
set -l fg4 a89984
set -l gray 928374
set -l red fb4934
set -l green b8bb26
set -l yellow fabd2f
set -l blue 83a598
set -l purple d3869b
set -l aqua 8ec07c
set -l orange fe8019

switch "$argv[1]-$argv[2]"
    case dark-hard
        set bg0 1d2021
    case dark-soft
        set bg0 32302f
    case light-\*
        switch "$argv[2]"
            case hard
                set bg0 f9f5d7
            case soft
                set bg0 f2e5bc
            case '*'
                set bg0 fbf1c7
        end
        set bg1 ebdbb2
        set bg2 d5c4a1
        set bg3 bdae93
        set bg4 a89984
        set fg0 282828
        set fg1 3c3836
        set fg2 504945
        set fg3 665c54
        set fg4 7c6f64
        set red 9d0006
        set green 79740e
        set yellow b57614
        set blue 076678
        set purple 8f3f71
        set aqua 427b58
        set orange af3a03
end

set -g term_color_palette \
    $bg0 cc241d 98971a d79921 458588 b16286 689d6a $fg4 \
    $gray $red $green $yellow $blue $purple $aqua $fg1
set -g term_color_foreground $fg1
set -g term_color_background $bg0
set -g term_color_selection_foreground $fg1
set -g term_color_selection_background $bg3
set -g term_color_cursor $fg1
set -g term_color_cursor_text_color $bg0

set -g fish_color_autosuggestion $bg3
set -g fish_color_cancel $bg3
set -g fish_color_command $yellow
set -g fish_color_comment $gray --italics
set -g fish_color_cwd $green
set -g fish_color_cwd_root $red
set -g fish_color_end $purple
set -g fish_color_error $red
set -g fish_color_escape $orange
set -g fish_color_history_current $green
set -g fish_color_host $fg
set -g fish_color_host_remote $yellow
set -g fish_color_keyword $red
set -g fish_color_normal $fg1
set -g fish_color_operator $purple
set -g fish_color_option $blue
set -g fish_color_param $fg1
set -g fish_color_quote $green
set -g fish_color_redirection $purple
set -g fish_color_search_match --background=$yellow
set -g fish_color_selection --background=$bg2
set -g fish_color_status $red
set -g fish_color_user $green
set -g fish_color_valid_path --underline

set -g fish_pager_color_completion $fg
set -g fish_pager_color_description $red
set -g fish_pager_color_prefix $fg --bold
set -g fish_pager_color_progress $blue
set -g fish_pager_color_selected_background --background=$bg2

set -g fish_color_prompt_insert_a $bg0 --background=$fg4
set -g fish_color_prompt_insert_b $fg4 --background=$bg2
set -g fish_color_prompt_insert_c $fg4 --background=$bg1
set -g fish_color_prompt_normal_a $bg0 --background=$blue
set -g fish_color_prompt_normal_b $fish_color_prompt_insert_b
set -g fish_color_prompt_normal_c $fg1 --background=$bg2
set -g fish_color_prompt_replace_a $bg0 --background=$aqua
set -g fish_color_prompt_replace_b $fish_color_prompt_insert_b
set -g fish_color_prompt_replace_c $fish_color_prompt_insert_c
set -g fish_color_prompt_visual_a $bg0 --background=$orange
set -g fish_color_prompt_visual_b $fish_color_prompt_insert_b
set -g fish_color_prompt_visual_c $bg0 --background=$bg4
set -g fish_color_prompt_inactive_a $bg4 --background=$bg1
set -g fish_color_prompt_inactive_b $fish_color_prompt_inactive_a
set -g fish_color_prompt_inactive_c $fish_color_prompt_inactive_a
set -g fish_color_prompt_error $bg0 --background=$red
