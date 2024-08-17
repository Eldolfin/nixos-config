{ pkgs, ... }:
{
  home.pkgs = with pkgs; [
    thunderbird
    signal-desktop
    vesktop
  ];
}
