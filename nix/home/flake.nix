{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ig.url = "git+https://koholi.net/git/tom/ig";
    ig.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ig,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import ./overlay.nix)];
        };
        ig' = ig.packages.${system}.default;
      in rec {
        packages = with lib; {
          default = buildHomeEnv base;

          mbp = with pkgs;
            buildHomeEnv {
              packages =
                base.packages
                ++ [
                  black
                  go
                  gopls
                  nodePackages.prettier
                  pyright
                  python3

                  exiftool
                  ffmpeg
                  ig'
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

              inherit (base) neovimPlugins zshPlugins;
            };

          pi = with pkgs;
            buildHomeEnv {
              packages =
                base.packages
                ++ [
                  black
                  go
                  gopls
                  nodePackages.prettier
                  pyright
                  python3
                ];

              inherit (base) neovimPlugins zshPlugins;
            };
        };

        lib = with pkgs; {
          base = {
            packages = [
              alejandra
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
              htop
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
              nix-tree
              p7zip
              perl
              progress
              pstree
              pv
              ripgrep
              rsbkb
              sqlite-interactive
              tmux
              tree
              unar
              unzip
              util-linux
              vim
              watch
              wget
              zip
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

            zshPlugins = [
              iterm2-shell-integration
              zsh-syntax-highlighting
            ];
          };

          buildHomeEnv = {
            packages,
            neovimPlugins,
            zshPlugins,
          }:
            with builtins;
              buildEnv {
                name = "home";
                paths =
                  packages
                  ++ zshPlugins
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
