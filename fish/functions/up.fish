function up
    argparse a/all -- $argv

    if command -sq brew
        brew update
        and brew upgrade
        and brew cleanup -s
    end

    if set -q _flag_all
        if command -sq brew
            brew bundle install
            and brew bundle cleanup
        end

        if command -sq apt-get
            sudo apt update
            and sudo apt upgrade
            and sudo apt autoremove
        end

        if command -sq mas
            mas upgrade
        end
    end
end
