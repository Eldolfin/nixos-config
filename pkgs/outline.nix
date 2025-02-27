let
  localPort = 8082;
  baseUrl = "outline.internal.eldolfin.top";
in {
  services = {
    outline = {
      enable = true;
      publicUrl = "https://${baseUrl}";
      port = localPort;
      storage = {
        storageType = "local";
      };
    };
    caddy = {
      enable = true;
      virtualHosts = {
        "https://${baseUrl}" = {
          extraConfig = ''
            tls internal
            reverse_proxy localhost:${toString localPort}
          '';
        };
        "http://${baseUrl}" = {
          extraConfig = ''
            reverse_proxy localhost:${toString localPort}
          '';
        };
      };
    };
  };
}
