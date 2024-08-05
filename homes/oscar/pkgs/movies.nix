{ pkgs, ... }:
{
  programs.mpv.scripts = with pkgs.mpvScripts; [
    # uosc # not enabled like this?
    thumbfast
    sponsorblock-minimal
    seekTo
    mpv-cheatsheet
    mpris
  ];
  home.packages = with pkgs; [
    # movies
    # jellyfin-media-player
    # jellyfin-mpv-shim
    # kodi-wayland
    vlc

    mpv
    invidtui
  ];
}
