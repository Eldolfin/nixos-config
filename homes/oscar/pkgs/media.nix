{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      # sponsorblock-minimal
      seekTo
      mpv-cheatsheet
      mpris
    ];
  };
  home.packages = with pkgs; [
    yt-dlp
    jellyfin-media-player
    # jellyfin-mpv-shim
    # kodi-wayland
    # vlc
    # popcorntime
    # invidtui
  ];
}
