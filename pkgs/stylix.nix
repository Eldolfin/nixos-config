{ pkgs, ... }: {
  stylix = {
    image = ./images/background.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    autoEnable = true;
    opacity.terminal = 0.9;
    polarity = "dark";
  };
}
