{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeter.enable = true;
    autoLogin = {
      enable = true;
      user = "oscar";
    };
  };
}
