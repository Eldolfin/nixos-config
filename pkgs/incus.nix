{
  virtualisation.incus = {
    enable = true;
    ui.enable = true;
  };
  users.users.oscar.extraGroups = ["incus-admin"];

  networking = {
    nftables.enable = true;

    # enable instances to get an ipv4 address (to access the internet)
    firewall.interfaces.incusbr0 = {
      allowedTCPPorts = [
        53
        67
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };
}
