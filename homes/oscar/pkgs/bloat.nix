# heavy packages
{ pkgs, ... }:
{
  programs.obs-studio = {
    # enable = true;
  };
  home.packages = with pkgs; [
    # libreoffice
    # rustdesk-flutter
    # handbrake
  ];
}
