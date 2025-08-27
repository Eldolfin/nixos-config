{pkgs, ...}: {
  programs.gnome-shell = {
    enable = true;
    extensions = [
      {
        id = "user-theme@gnome-shell-extensions.gnome-tweaks";
        package = pkgs.gnome-tweaks;
      }
    ];
  };
}
