{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
    vesktop
  ];
}
