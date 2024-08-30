{ inputs, ... }:
{
  # imports = [ inputs.nixcord.homeManagerModules.nixcord ];
  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = {

      frameless = true;
      plugins = {
        betterUploadButton.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        dearrow.enable = true;
        fakeNitro.enable = true;
      };
    };
  };
}
