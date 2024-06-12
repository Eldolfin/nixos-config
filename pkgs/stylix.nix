{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./images/background.jpg;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    autoEnable = true;
    opacity.terminal = 0.9;
    polarity = "dark";
    targets = {
      gnome.enable = true;
    };

    fonts = {
      serif = {
        package = pkgs.meslo-lgs-nf;
        name = "UbuntuMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.meslo-lgs-nf;
        name = "meslo-lgs-nf";
      };

      monospace = {
        package = pkgs.meslo-lgs-nf;
        name = "meslo-lgs-nf";
      };

      emoji = {
        package = pkgs.meslo-lgs-nf;
        name = "meslo-lgs-nf";
      };

      sizes.terminal = 20;
    };
  };
}
