function up
    argparse a/all -- $argv

    if command -sq brew
        brew update
        and brew upgrade
        and brew cleanup -s
    end

    if set -q TERMUX_VERSION
        pkg update
        and pkg upgrade
        and apt autoremove
    end

    if set -q _flag_all
        if command -sq brew && set -q HOMEBREW_BUNDLE_FILE
            brew bundle install
            and brew bundle cleanup
        end

        if command -sq apt-get && not set -q TERMUX_VERSION
            sudo apt-get update
            and sudo apt-get upgrade
            and sudo apt-get autoremove
        end

        if command -sq mas
            mas upgrade
        end
    end
end
