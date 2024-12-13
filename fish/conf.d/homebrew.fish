if test -d /opt/homebrew
    set -gx HOMEBREW_PREFIX /opt/homebrew
else if test -d /home/linuxbrew/.linuxbrew
    set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
else
    return
end

fish_add_path -g $HOMEBREW_PREFIX/bin
fish_add_path -g $HOMEBREW_PREFIX/opt/{man-db,python}/libexec/bin
fish_add_path -g $HOMEBREW_PREFIX/opt/{coreutils,findutils,gnu-sed,gnu-tar,grep}/libexec/gnubin
