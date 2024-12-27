{pkgs, ...}: {
  stylix = {
    enable = true;
    image = ./images/background.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    autoEnable = true;
    polarity = "light";
    targets = {
      grub.useImage = true; # :)
    };

    # cursor.package = pkgs.bibata-cursors;
    # cursor.name = "Bibata-Modern-Ice";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes.terminal = 20;
    };
  };
}
