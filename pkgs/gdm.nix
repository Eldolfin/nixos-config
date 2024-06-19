{
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.xserver.displayManager = {
    gdm = {
      enable = true;
    };
  };
}
