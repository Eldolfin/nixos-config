# heavy packages
{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = [pkgs.obs-studio-plugins.wlrobs];
  };
  home.packages = with pkgs; [
    libreoffice
    gimp
    vault
    # rustdesk-flutter
    # handbrake
  ];
}
