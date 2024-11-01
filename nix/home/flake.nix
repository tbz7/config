{
  inputs = {
    helix = {
      url = "github:helix-editor/helix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    ig = {
      url = "git+https://koholi.net/git/tom/ig";
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
    vcs-status = {
      url = "git+https://koholi.net/git/tom/vcs-status";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      nixpkgs = import inputs.nixpkgs {inherit system;};
      pkgs =
        nixpkgs
        // (nixpkgs.callPackage ./pkgs.nix {})
        // (with inputs; {
          helix = helix.packages.${system}.default;
          ig = ig.packages.${system}.default;
          scls = scls.defaultPackage.${system};
          vcs-status = vcs-status.packages.${system}.default;
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
              diffedit3
              diffutils
              dig
              dos2unix
              file
              findutils
              fish
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
              tree
              typescript-language-server
              unar
              unzip
              util-linux
              vcs-status
              vim
              vscode-langservers-extracted
              watch
              wget
              yaml-language-server
              zip

              (linkFarm "home-inputs" (lib.mapAttrsToList (name: input: {
                  name = "share/nix/inputs/${name}";
                  path = input;
                })
                self.inputs))
            ];
            postBuild = ''rm $out/bin/{id,stty,uptime}'';
          };

          mbp = buildEnv {
            name = "home-mbp";
            paths = [
              default

              go
              gopls
              jujutsu

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
              ig
              jujutsu
              shpool
            ];
          };
        };
      });
}
