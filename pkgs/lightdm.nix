{
  services.xserver.displayManager.lightdm = {
    enable = true;
    extraConfig = ''
      logind-check-graphical=true
    '';
  };
}
