{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ig = {
      url = "git+https://koholi.net/git/tom/ig";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-env = {
      url = "git+https://koholi.net/git/tom/neovim-env";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    scls = {
      url = "github:estin/simple-completion-language-server";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = {
    self,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      nixpkgs = import inputs.nixpkgs {inherit system;};
      pkgs =
        nixpkgs
        // (nixpkgs.callPackage ./pkgs.nix {})
        // (with inputs; {
          ig = ig.packages.${system}.default;
          neovim-env = neovim-env.packages.${system}.default;
          scls = scls.defaultPackage.${system};
        });
    in
      with pkgs; {
        packages = rec {
          default = buildEnv {
            name = "home-default";
            paths = [
              alejandra
              bash-language-server
              colordiff
              coreutils-full
              curlHTTP3
              diffutils
              dig
              dos2unix
              file
              findutils
              fzf
              gawk
              git
              gnugrep
              gnused
              gnutar
              gzip
              helix
              htop
              iterm2-shell-integration
              jq
              less
              lua-language-server
              luajit
              man
              moreutils
              mtr
              ncdu
              ncurses
              neovim-env
              netcat
              nil
              nix-tree
              p7zip
              perl
              progress
              pstree
              pv
              python3
              python312Packages.python-lsp-server
              ripgrep
              rsbkb
              ruff
              scls
              shellcheck
              sqlite-interactive
              taplo
              tmux
              tree
              typescript-language-server
              unar
              unzip
              util-linux
              vscode-langservers-extracted
              watch
              wget
              yaml-language-server
              zip
              zsh-syntax-highlighting

              (linkFarm "home-inputs" (lib.mapAttrsToList (name: input: {
                  name = "share/nix/inputs/${name}";
                  path = input;
                })
                self.inputs))
            ];
          };

          mbp = buildEnv {
            name = "home-mbp";
            paths = [
              default

              go
              gopls

              exiftool
              ffmpeg
              ig
              imagemagick
              mediainfo
              oxipng
              supmover

              bchunk
              ciso
              # mame-tools
              ps3dec
              wudcompress

              android-tools
              cliclick
              mas
              rclone
            ];
          };

          bee = buildEnv {
            name = "home-bee";
            paths = [
              default

              dockerfile-language-server-nodejs
              go
              gopls
            ];
          };
        };
      });
}
