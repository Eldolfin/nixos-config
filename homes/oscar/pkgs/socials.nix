{ pkgs, ... }:
{
  imports = [ ./discord ];
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
  ];
}
