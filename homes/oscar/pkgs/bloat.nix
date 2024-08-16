# heavy packages
{ pkgs, ... }:
{
  programs.obs-studio = {
    # enable = true;
  };
  home.packages = with pkgs; [
    # gimp
    # libreoffice
    # rustdesk-flutter
    # handbrake
  ];
}
