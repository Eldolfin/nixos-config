{
  services = {
    # bluetooth media control
    mpris-proxy.enable = true;

    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };
  };
}
