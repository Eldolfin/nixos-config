{ pkgs, lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = lib.mkForce "16";
    };
  };
  # programs.wezterm.enable = true;
  home.packages = with pkgs; [
    # kitty
    # cool-retro-term
  ];
}
