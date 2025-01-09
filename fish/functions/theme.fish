function theme --description 'Apply theme presets across various tools'
    argparse l/list U/universal -- $argv

    if set -q _flag_list
        printf '%s\n' gruvbox iceberg kanagawa tokyonight
        return 0
    end

    switch "$argv[1]"
        case gruvbox
            set -f fish_theme Gruvbox
            set -f helix_theme gruvbox
            set -f vim_colorscheme retrobox
        case iceberg
            set -f fish_theme Iceberg
            set -f helix_theme iceberg-dark
            set -f vim_colorscheme habamax
        case kanagawa
            set -f fish_theme Kanagawa
            set -f helix_theme kanagawa
            set -f vim_colorscheme habamax
        case tokyonight
            set -f fish_theme TokyoNight\ Moon
            set -f helix_theme tokyonight_moon
            set -f vim_colorscheme habamax
        case '*'
            echo "Invalid theme: $argv[1]"
            return 1
    end

    if set -q _flag_universal
        echo y | fish_config theme save $fish_theme
        set -eg HELIX_THEME VIM_COLORSCHEME
        set -Ux HELIX_THEME $helix_theme
        set -Ux VIM_COLORSCHEME $vim_colorscheme
    else
        fish_config theme choose $fish_theme
        set -gx HELIX_THEME $helix_theme
        set -gx VIM_COLORSCHEME $vim_colorscheme
    end

    return 0
end
