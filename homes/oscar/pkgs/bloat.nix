{ pkgs, ... }:

{
  # long to build...
  home.packages = with pkgs; [
    # rustdesk
    obs-studio
    # handbrake
  ];
}
