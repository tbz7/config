function up
    argparse no-apt no-brew no-mas f -- $argv

    if command -sq apt-get && ! set -q _flag_no_apt
        sudo apt update
        and sudo apt upgrade
        and sudo apt autoremove
    end

    if command -sq brew && ! set -q _flag_no_brew
        brew update
        and brew upgrade
        and brew cleanup -s
    end

    if command -sq mas && ! set -q SSH_CONNECTION && ! set -q _flag_no_mas
        mas upgrade
    end
end
