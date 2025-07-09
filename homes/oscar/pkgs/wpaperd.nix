{
  backgrounds,
  pkgs,
  ...
}: {
  home.packages = [pkgs.swaybg];
  stylix.targets.wpaperd.enable = false;
  services.wpaperd = {
    enable = true;
    settings = {
      any = {
        path = "${backgrounds}/";
      };
    };
  };
}
