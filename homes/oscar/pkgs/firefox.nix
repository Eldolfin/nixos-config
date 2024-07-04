{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.homemanager = {
      isDefault = true;
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
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        "browser.search.region" = "US";
        "browser.search.isUS" = true;
        "general.useragent.locale" = "en-US";
        # privacy related
        "privacy.resistFingerprinting" = true;
        "privacy.donottrackheader.enabled" = true;
        "dom.battery.enabled" = false;
        "geo.enabled" = true;
      };
      bookmarks = [
        {
          name = "Nix";
          toolbar = true;
          bookmarks = [
            {
              name = "Nixos search";
              url = "search.nixos.org";
            }
            {
              name = "Home-manager search";
              url = "https://mipmip.github.io/home-manager-option-search/";
            }
            {
              name = "Manual";
              url = "https://ryantm.github.io/nixpkgs/functions/library/attrsets";
            }
          ];
        }
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
        consent-o-matic
        dearrow
        decentraleyes
        french-dictionary
        french-language-pack
        jump-cutter
        github-file-icons
        gruvbox-dark-theme
        libredirect
        privacy-badger
        refined-github
        return-youtube-dislikes
        sponsorblock
        ublock-origin
        vimium
      ];
      search = {
        force = true;
        default = "selfhosted";
        privateDefault = "selfhosted";
        engines = {
          "selfhosted" = {
            urls = [ { template = "https://search.eldolfin.top/search?q={searchTerms}"; } ];
          };

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
