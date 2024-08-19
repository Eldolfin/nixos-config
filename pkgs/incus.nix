{
  virtualisation.incus = {
    enable = true;
    ui.enable = true;
  };
  users.users.oscar.extraGroups = [ "incus-admin" ];

  networking.nftables.enable = true;
}
