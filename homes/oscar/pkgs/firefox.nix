{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    profiles.homemanager = {
      bookmarks = [
        {
          name = "Dashboard";
          url = "http://192.168.1.1:7575";
        }
        {
          name = "YT";
          url = "https://invidious.eldolfin.top/feed/subscriptions";
        }
      ];
    };
  };
}
