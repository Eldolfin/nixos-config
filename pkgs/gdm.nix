{
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.displayManager = {
    gdm = {
      enable = true;
    };
  };
}
