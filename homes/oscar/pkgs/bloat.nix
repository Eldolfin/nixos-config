# heavy packages
{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = [pkgs.obs-studio-plugins.wlrobs];
  };
  home.packages = with pkgs; [
    libreoffice
    gimp
    # rustdesk-flutter
    # handbrake
  ];
}
