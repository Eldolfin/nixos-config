{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeter.enable = true;
    extraConfig = ''
      logind-check-graphical=true
    '';
  };
}
