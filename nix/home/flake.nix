{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ig = {
      url = "git+https://koholi.net/git/tom/ig";
      inputs.nixpkgs.follows = "nixpkgs";
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
    flake-utils.lib.eachDefaultSystem (
      system: let
        nixpkgs = import inputs.nixpkgs {inherit system;};
        pkgs =
          nixpkgs
          // (nixpkgs.callPackage ./pkgs.nix {})
          // (with inputs; {
            ig = ig.packages.${system}.default;
            scls = scls.defaultPackage.${system};
          });
      in rec {
        packages = with lib; {
          default = buildHomeEnv base;

          mbp = with pkgs;
            buildHomeEnv {
              packages =
                base.packages
                ++ [
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

              inherit (base) neovimPlugins;
            };

          pi = with pkgs;
            buildHomeEnv {
              packages =
                base.packages
                ++ [
                  dockerfile-language-server-nodejs
                  go
                  gopls
                ];

              inherit (base) neovimPlugins;
            };
        };

        lib = with pkgs; {
          base = {
            packages = [
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
              neovim
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
              vim
              vscode-langservers-extracted
              watch
              wget
              yaml-language-server
              zip
              zsh-syntax-highlighting
            ];

            neovimPlugins = with vimPlugins; {
              start = [
                cmp-buffer
                cmp-nvim-lsp
                cmp-nvim-lua
                cmp-path
                cmp-vsnip
                conform-nvim
                fidget-nvim
                gruvbox-nvim
                iceberg-vim
                lspkind-nvim
                lualine-nvim
                nord-vim
                nvim-cmp
                nvim-lspconfig
                nvim-tree-lua
                oil-nvim
                plenary-nvim
                telescope-nvim
                tokyonight-nvim
                vim-caddyfile
                vim-gotham
                vim-suda
                vim-vsnip
              ];
              opt = [
                nvim-web-devicons
              ];
            };
          };

          buildHomeEnv = {
            packages,
            neovimPlugins,
          }:
            with builtins;
              buildEnv {
                name = "home";
                paths =
                  packages
                  ++ [
                    (linkFarm "neovim-plugins" (pkgs.lib.flatten (attrValues (mapAttrs (phase: p:
                      map (plugin: {
                        name = "share/nvim/site/pack/default/${phase}/${plugin.pname}";
                        path = plugin;
                      })
                      p)
                    neovimPlugins))))
                    (
                      linkFarm "home-inputs" (
                        pkgs.lib.mapAttrsToList (name: input: {
                          name = "share/nix/inputs/${name}";
                          path = input;
                        })
                        self.inputs
                      )
                    )
                  ];
              };
        };
      }
    );
}
