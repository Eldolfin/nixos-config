{ pkgs, inputs, ... }:
{
  imports = [ inputs.nur.hmModules.nur ];
  programs.firefox = {
    enable = true;
    profiles.homemanager = {
      settings = {
        extensions.autoDisableScopes = 0;
      };
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
      extensions = with inputs.nur.hmModules.nur.repos.rycee.firefox-addons; [
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
