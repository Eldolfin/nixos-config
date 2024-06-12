{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.homemanager = {
      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter,Wikipedia (en),YouTube,eBay";
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.addons" = false;
        "browser.urlbar.suggest.pocket" = false;
        "browser.urlbar.suggest.topsites" = false;
      };
      bookmarks = [
        {
          name = "Bookmarks";
          toolbar = true;
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
        }
      ];
      extensions = with config.nur.repos.rycee.firefox-addons; [
        bitwarden
        # chatgptbox
        consent-o-matic
        dearrow
        decentraleyes
        french-dictionary
        french-language-pack
        floccus
        jump-cutter
        github-file-icons
        gruvbox-dark-theme
        libredirect
        privacy-badger
        return-youtube-dislikes
        sponsorblock
        ublock-origin
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
