# heavy packages
{pkgs, ...}: {
  programs.obs-studio = {
    # enable = true;
  };
  home.packages = with pkgs; [
    libreoffice
    gimp
    # rustdesk-flutter
    # handbrake
  ];
}
