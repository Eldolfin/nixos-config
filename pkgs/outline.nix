{pkgs, ...}: let
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

    # TODO: configure OIDC
    # https://wiki.nixos.org/wiki/Outline
    dex = {
      enable = true;
      settings = {
        issuer = "http://dex.localhost";
        storage.type = "sqlite3";
        web.http = "127.0.0.1:5556";
        enablePasswordDB = true;
        staticClients = [
          {
            id = "outline";
            name = "Outline Client";
            redirectURIs = ["http://localhost:3000/auth/oidc.callback"];
            secretFile = "${pkgs.writeText "outline-oidc-secret" "test123"}";
          }
        ];
        staticPasswords = [
          {
            email = "user.email@example.com";
            # bcrypt hash of the string "password": $(echo password | htpasswd -BinC 10 admin | cut -d: -f2)
            hash = "10$TDh68T5XUK10$TDh68T5XUK10$TDh68T5XUK";
            username = "test";
            # easily generated with `$ uuidgen`
            userID = "6D196B03-8A28-4D6E-B849-9298168CBA34";
          }
        ];
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
