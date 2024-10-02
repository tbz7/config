{pkgs}:
with pkgs; {
  ciso = stdenv.mkDerivation rec {
    pname = "ciso";
    version = "v1.0.2";
    src = fetchFromGitHub {
      repo = "ciso";
      owner = "jamie";
      rev = version;
      hash = "sha256-/VnObXZq62fvfd3kasNdYsh10vgLezszHEssuUS8qoc=";
    };
    buildInputs = [zlib];
    buildPhase = "$CC -lz ciso.c";
    installPhase = "install -Dm755 a.out $out/bin/ciso";
  };

  cliclick = stdenv.mkDerivation rec {
    pname = "cliclick";
    version = "5.1";
    src = fetchFromGitHub {
      repo = "cliclick";
      owner = "BlueM";
      rev = version;
      hash = "sha256-8lWfeRPCF2zn9U79uZkhlj0izGSueTZuYpJx1LgsyfQ=";
    };
    buildInputs = [darwin.apple_sdk.frameworks.Cocoa perl];
    env.NIX_CFLAGS_COMPILE = "-include cliclick_Prefix.pch -I Actions -I .";
    installPhase = "install -Dm755 cliclick $out/bin/cliclick";
  };

  coreutils-full = buildEnv {
    name = "coreutils-full";
    paths = [coreutils-full hello];
    postBuild = ''rm $out/bin/{id,hello,uptime}'';
  };

  iterm2-shell-integration = stdenv.mkDerivation {
    pname = "iterm2-shell-integration";
    version = "2024-08-10";
    src = fetchFromGitHub {
      repo = "iTerm2-shell-integration";
      owner = "gnachman";
      rev = "c2a41928ff1e224ecaa054035331b2a8aa7416a3";
      hash = "sha256-meYWZ3ZMsVVh8wMHALJuTjBLopcAa4LVpCRtClHJ7yA=";
    };
    phases = ["installPhase" "fixupPhase"];
    installPhase = ''
      install -Dm644 $src/shell_integration/zsh $out/share/zsh/plugins/iterm2-shell-integration.zsh
      install -Dm755 $src/utilities/* -t $out/bin
    '';
  };

  nerdfonts-jetbrains-mono = nerdfonts.override {fonts = ["JetBrainsMono"];};

  ps3dec = stdenv.mkDerivation {
    pname = "ps3dec";
    version = "r5";
    src = fetchFromGitHub {
      repo = "PS3Dec";
      owner = "al3xtjames";
      rev = "7d1d27f028aa86cd961a89795d0d19a9b3771446";
      hash = "sha256-dgH9xMOAqDhfG2dWE+oX2wNqrcsSO8dMTo5f3ETSxTw=";
    };
    buildInputs = [cmake llvmPackages_12.openmp mbedtls];
    installPhase = "install -Dm755 Release/PS3Dec $out/bin/ps3dec";
  };

  supmover = stdenv.mkDerivation rec {
    pname = "supmover";
    version = "v2.4.2";
    src = fetchFromGitHub {
      repo = "SupMover";
      owner = "MonoS";
      rev = version;
      hash = "sha256-Xdr2b/RYHLIELJ2SWqOoLb5yYAcA9fLUhzeQrf4V6U4=";
    };
    patches = [./patches/supmover.patch];
    installPhase = "install -Dm755 supmover $out/bin/supmover";
  };

  wudcompress = stdenv.mkDerivation rec {
    pname = "wudcompress";
    version = src.rev;
    src = fetchFromGitHub {
      repo = "wudcompress";
      owner = "cemu-project";
      rev = "b0ab5f6b6a46a1972dbbd802b6d04d46de003aab";
      hash = "sha256-qSupekhkwMn+wKZSVBOHfcr9Tc2UuT4ZOI2Z5P+4CCs=";
    };
    patches = [./patches/wudcompress.patch];
    buildPhase = "$CC WudCompress/*.cpp";
    installPhase = "install -Dm755 a.out $out/bin/wudcompress";
  };

  zsh-syntax-highlighting = zsh-syntax-highlighting.overrideAttrs (_: {
    postInstall = ''
      mkdir -p $out/share/zsh
      mv $out/share/zsh-syntax-highlighting $out/share/zsh/plugins
    '';
  });
}
