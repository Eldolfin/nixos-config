{
  pkgs,
  lib,
  config,
  ...
}:
let
  isTour = config.networking.hostName == "oscar-tour";
  termFontSize = if isTour then 22 else 12;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = lib.mkForce termFontSize;
    };
  };
  # programs.wezterm.enable = true;
  home.packages = with pkgs; [
    # kitty
    # cool-retro-term
  ];
}
