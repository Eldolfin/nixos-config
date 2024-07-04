{ pkgs, ... }:

{
  programs.obs-studio = {
    # enable = true;
  };
  # long to build...
  home.packages = with pkgs; [
    # rustdesk
    # handbrake
  ];
}
