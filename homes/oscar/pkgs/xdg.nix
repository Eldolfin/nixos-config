{
  xdg = {
    systemDirs.config = [
      "/etc/xdg"
    ];

    mimeApps.defaultApplications = {
      "application/pdf" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
    };
  };
}
