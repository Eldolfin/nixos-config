{pkgs, ...}: {
  # imports = [ inputs.nixcord.homeManagerModules.nixcord ];
  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop = {
      enable = true;
      package = pkgs.vesktop.overrideAttrs (prev: {
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "discord";
            desktopName = "Discord";
            exec = "vesktop %U";
            icon = "discord";
            startupWMClass = "Discord";
            genericName = "Internet Messenger";
            keywords = [
              "discord"
              "vencord"
              "vesktop"
            ];
          })
        ];
      });
    };

    config = {
      enabledThemes = ["stylix.theme.css"];
      frameless = true;
      plugins = {
        betterUploadButton.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        dearrow.enable = true;
        fakeNitro.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        implicitRelationships.enable = true;
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageClickActions.enable = true;
        messageLogger.enable = true;
        noF1.enable = true; # f1 opens discord help center in the browser by default
        noProfileThemes.enable = true;
        onePingPerDM.enable = true;
        platformIndicators.enable = true;
        readAllNotificationsButton.enable = true;
        replaceGoogleSearch = {
          enable = true;
          customEngineName = "self-hosted";
          customEngineURL = "https://search.eldolfin.top/search?q=";
        };
        revealAllSpoilers.enable = true;
        reverseImageSearch.enable = true;
        roleColorEverywhere.enable = true;
        showHiddenChannels.enable = true;
        showMeYourName.enable = true;
        silentTyping.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        unindent.enable = true;
        voiceChatDoubleClick.enable = true;
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
        webScreenShareFixes.enable = true;
      };
    };
  };
}
