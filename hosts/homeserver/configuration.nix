{
  imports = [
    ./hardware-configuration.nix
    ../../pkgs/attic-server.nix
    ../../pkgs/grub.nix
    ../../pkgs/open-webui.nix
    ../../pkgs/nvidia.nix
  ];

  networking.hostName = "homeserver";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYy4UzTcGEALaWgPLD/Rc495SblQc6iX4BOCBjYTWXG oscar@oscar-tour''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJEqNsXpu4PMoRWAmkY8nLcxQKUdfPvvdaR/uT3115oT oscar@nixos''
  ];
  users.users.oscar.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYy4UzTcGEALaWgPLD/Rc495SblQc6iX4BOCBjYTWXG oscar@oscar-tour''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJEqNsXpu4PMoRWAmkY8nLcxQKUdfPvvdaR/uT3115oT oscar@nixos''
  ];
}
