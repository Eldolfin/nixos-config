{
  imports = [../activitywatch.nix];
  services = {
    avizo.enable = true;
    clipse = {
      enable = true;
      imageDisplay.type = "kitty";
      historySize = 2000;
    };
    swaync = {
      enable = true;
    };
    wlsunset = {
      enable = true;
      latitude = 48.864716;
      longitude = 2.349014;
    };
  };
}
