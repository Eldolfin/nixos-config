{ pkgs, ... }:
{
  programs.bun.enable = true;
  home.packages = with pkgs; [
    vscode-fhs
    # jetbrains
    # jetbrains-toolbox

    # docker
    docker-compose
    dive

    # java
    # jetbrains.idea-community
    # jetbrains.idea-ultimate
    # jetbrains.pycharm-professional
    # maven
    # openjdk17

    # rust
    # evcxr
    # rust-analyzer
    rustup
    # bacon

    # for leptos
    # trunk
    # leptosfmt
    # cargo-leptos
    # cargo-generate
    # sass # for css

    # c/c++
    # jetbrains.clion
    # valgrind
    # gcc12
    clang-tools
    clang
    # criterion
    # gtest
    # gcovr
    # boost
    # ninja
    gdb

    # go
    # go
    # gopls
    # gotools

    # python
    # jetbrains.pycharm-professional
    # jupyter-all
    # mypy
    # poetry
    # poethepoet
    # black
    # conda

    (python311Full.withPackages (ppkgs: [
      # ppkgs.scipy
      # ppkgs.matplotlib
      # ppkgs.notebook
      # ppkgs.numpy
      ppkgs.pytest
      ppkgs.psutil
    ]))
    python311Packages.pip
    # python311Packages.bpython
    # grip # github markdown preview

    # c#
    # mono
    # jetbrains.rider
    # dotnet-sdk_7
    # omnisharp-roslyn

    # js
    yarn
    nodejs
    typescript
    # bun
    # deno

    # nix
    # nixpkgs-fmt
    # nil

    # kubernetes
    # kubectl
    # minikube

    # android
    # android-studio
    android-tools # adb, fastboot etc

    # Haskell
    # ghc

    # ocaml
    # ocamlPackages.ocaml-lsp
    # ocamlPackages.ocamlformat

    # Common lisp
    # sbcl

    # sql
    # sqlfluff
    # dbeaver

    # zig
    # zig
    # zls

    # php
    # php83Packages.composer
    # php83

    # lua?
    # luajitPackages.luarocks

    # Language servers
    # now in helix config directly
    # lua-language-server
    # nodePackages_latest.typescript-language-server
    # docker-compose-language-service
    # yaml-language-server
    # dockerfile-language-server-nodejs
    # python311Packages.python-lsp-server

    # Arduino
    # arduino

    # misc
    # graphviz
    nodePackages.live-server
    sshfs
    gh
    git
    git-lfs
    entr
    devenv
    difftastic
    # godot_4
    # dig
    # mold
    # act # github action runner
  ];
}
