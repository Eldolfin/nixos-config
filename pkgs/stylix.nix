{pkgs, ...}:
{
    stylix.image = /etc/nixos/images/background.jpg;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    stylix.autoEnable = true;
}