{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../pkgs/wol-agent.nix
  ];

  eldolfin.services.wol-agent.machine-name = "oracle";
  networking.wireguard.interfaces = {
    freebox = {
      ips = ["192.168.27.90/32"];
      mtu = 1360;
      privateKeyFile = "/run/secrets/wireguard/oracle/privateKey";
      peers = [
        {
          allowedIPs = ["192.168.27.64/27" "192.168.1.0/24"];
          endpoint = "88.181.110.252:2802";
          publicKey = "KS+dja7K1VsBpfNsIn2kBJln/PPrCfv7hbHluF12EWw="; # pragma: allowlist secret
          presharedKeyFile = "/run/secrets/wireguard/oracle/presharedKey";
        }
      ];
    };
    hostName = "instance-20250108-2030";
    domain = "";
  };
  services.xserver.virtualScreen = {
    x = 1920;
    y = 1080;
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
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
