{
  services = {
    atticd = {
      enable = true;
      environmentFile = "/etc/atticd.env";
      settings = {
        listen = "127.0.0.1:8080";
        jwt = {};
      };
    };

    caddy = {
      enable = true;
      virtualHosts = {
        "https://acttic.eldolfin.top" = {
          extraConfig = ''
            reverse_proxy localhost:8080
          '';
        };
      };
    };
  };

  networking = {
    firewall.allowedTCPPorts = [80 443];
    firewall.allowedUDPPorts = [443];
  };
}
