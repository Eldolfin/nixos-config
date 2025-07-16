{
  # TODO: cursor_trail = 3
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Frappe";
    shellIntegration.enableFishIntegration = true;
    settings = {
      cursor_trail = 3;
      scrollback_lines = 10000;
      update_check_interval = 0;
    };
  };
}
