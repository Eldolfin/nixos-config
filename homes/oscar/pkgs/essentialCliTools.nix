{
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    # exit terminal when zellij exits
    ZELLIJ_AUTO_EXIT = "true";
  };
  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    skim.enable = true;
    zellij = {
      enable = true;
      # this starts zellij late, meaning we init zsh twice
      # enableZshIntegration = true;
    };
    zsh.initExtraFirst = ''
      eval "$(${lib.getExe pkgs.zellij} setup --generate-auto-start zsh)"
    '';

    zsh.enable = true;
    lazygit = {
      enable = true;
      settings = {
        git.paging.externalDiffCommand = "${lib.getExe pkgs.difftastic} --color=always --display=inline";
      };
    };
  };
}
