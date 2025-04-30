{pkgs, ...}: {
  home.packages = with pkgs; [
    # required by systemswitch (TODO: put runtime dependency in its package)
    pulseaudio
  ];
  home.sessionVariables = {
    # exit terminal when zellij exits
    ZELLIJ_AUTO_EXIT = "true";
  };
  programs = {
    bat.enable = true;
    btop.enable = true;
    carapace.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    skim.enable = true;
    # zellij.enable = true;
    zoxide.enable = true;

    mcfly = {
      enable = true;
      fzf.enable = true;
    };

    lazygit = {
      enable = true;
      settings = {
        # too slow for big diffs
        # git.paging.externalDiffCommand = "${lib.getExe pkgs.difftastic} --color=always --display=inline";
      };
    };
  };
}
