{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.homemanager = {
      isDefault = true;
      settings = {
        "general.smoothScroll" = false;
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter,YouTube,eBay";
        "browser.startup.page" = 3; # Resume last session.
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
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.search.region" = "US";
        "browser.search.isUS" = true;
        "general.useragent.locale" = "en-US";

        "sidebar.main.tools" = "history";

        # privacy related
        # "privacy.resistFingerprinting" = true; # annoying to have the wrong time on zeus
        "privacy.donottrackheader.enabled" = true;
        "dom.battery.enabled" = false;
        "geo.enabled" = false;
      };
      bookmarks = {
        force = true; # no choice but to remove other bookmarks...
        settings = [
          {
            name = "Bookmarks";
            toolbar = true;
            bookmarks = [
              {
                name = "Dashboard";
                url = "http://192.168.1.1:7575";
              }
              {
                name = "awatcher";
                url = "http://127.0.0.1:5600";
              }
            ];
          }
        ];
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          aw-watcher-web
          bitwarden
          consent-o-matic
          dearrow
          french-dictionary
          french-language-pack
          jump-cutter
          github-file-icons
          libredirect
          refined-github
          return-youtube-dislikes
          sponsorblock
          ublock-origin
          vimium
        ];
      };
      search = {
        force = true;
        default = "selfhosted";
        privateDefault = "selfhosted";
        engines = {
          "selfhosted" = {
            urls = [{template = "https://search.eldolfin.top/search?q={searchTerms}";}];
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
                  {
                    name = "size";
                    value = "100";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "NixOS Wiki" = {
            urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
            icon = "https://wiki.nixos.org/favicon.png";
            definedAliases = ["@nw"];
          };

          "Crates io" = {
            urls = [{template = "https://crates.io/search?q={searchTerms}";}];
            icon = "https://crates.io/favicon.ico";
            definedAliases = ["@rp"];
          };

          "Home manager" = {
            urls = [
              {template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";}
            ];
            icon = "https://home-manager-options.extranix.com/images/favicon.png";
            definedAliases = ["@hm"];
          };

          "bing".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
      };
    };
  };
}
