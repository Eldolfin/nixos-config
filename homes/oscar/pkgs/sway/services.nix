{
  imports = [../activitywatch.nix];
  services = {
    avizo.enable = true;
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
