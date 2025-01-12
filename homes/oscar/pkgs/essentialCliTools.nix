{
  pkgs,
  lib,
  ...
}: {
  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    skim.enable = true;
    zellij.enable = true;
    zsh.enable = true;
    lazygit = {
      enable = true;
      settings = {
        git.paging.externalDiffCommand = "${lib.getExe pkgs.difftastic} --color=always --display=inline";
      };
    };
  };
}
