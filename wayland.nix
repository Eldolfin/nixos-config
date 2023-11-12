{ pkgs, ... }:
{
  imports = [
    ./sddm.nix
  ];
  # not working :(
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
  };
  environment.systemPackages = with pkgs; [
    swaylock
  ];
}
