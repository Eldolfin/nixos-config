{
  pkgs,
  isTour,
  ...
}: {
  programs.gh.enable = true;
  home.packages = with pkgs; (
    [
      # docker
      docker-compose
      dive

      rustc
      cargo
      clippy

      # c/c++
      cmake
      clang-tools
      gcc
      gdb

      (python3.withPackages (ppkgs:
        with ppkgs; [
          ipython
          pip
        ]))

      nodejs
      typescript
      pnpm
      # misc
      nodePackages.live-server
      sshfs
      entr
      tea
      yazi
      just
      sd
    ]
    ++ lib.optional isTour nvtopPackages.nvidia
  );
}
