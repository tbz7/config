status is-interactive || return

function __helix_theme_hack_update --on-variable HELIX_THEME
    if test -n "$HELIX_THEME" -a "$HELIX_THEME" != tokyonight_moon
        set -gx HELIX_RUNTIME ~/.local/share/helix/runtime-$HELIX_THEME
        mkdir -p $HELIX_RUNTIME/themes
        echo "inherits = '$HELIX_THEME'" >$HELIX_RUNTIME/themes/tokyonight_moon.toml
    else
        set -e HELIX_RUNTIME
    end
end

__helix_theme_hack_update
