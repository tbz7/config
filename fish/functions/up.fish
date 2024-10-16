function up
    argparse no-apt no-brew no-mas no-nix f -- $argv

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

    if command -sq nix && ! set -q _flag_no_nix
        if set -q _flag_f
            nix registry pin nixpkgs
            and nix flake update --flake (realpath $__fish_config_dir/../nix/home)
        end
        nix profile upgrade --all
        and nix profile wipe-history
        and nix store gc
    end
end
