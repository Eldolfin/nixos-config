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
  };
}
