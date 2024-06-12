{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    settings = {
      extensions.autoDisableScopes = 0;
    };
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
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        privacy-badger
        sponsorblock
        vimium
      ];
      search = {
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
      };
    };
  };
}
