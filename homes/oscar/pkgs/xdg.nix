{pkgs, ...}: {
  xdg = {
    mimeApps.defaultApplications = {
      "application/pdf" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
    };
    portal.enable = true;
    # from https://github.com/YaLTeR/niri/wiki/Important-Software
    portal.extraPortals = with pkgs; [
      # implements most of the basic functionality, this is the "default fallback portal".
      xdg-desktop-portal-gtk
      # required for screencasting support
      xdg-desktop-portal-gnome
      # implements the Secret portal, required for certain apps to work
      gnome-keyring
    ];
  };
}
