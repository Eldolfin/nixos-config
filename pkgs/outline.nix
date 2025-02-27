{pkgs, ...}: let
  # local only port
  outlinePort = 8082;
  outlineUrl = "outline.internal.eldolfin.top";
  dexPort = 8083;
  dexUrl = "dex.internal.eldolfin.top";
  dexOutlineSecretFile = "${pkgs.writeText "outline-oidc-secret" "test123"}";
in {
  # https://wiki.nixos.org/wiki/Outline
  services = {
    outline = {
      enable = true;
      publicUrl = "https://${outlineUrl}";
      port = outlinePort;
      storage = {
        storageType = "local";
      };
      oidcAuthentication = {
        # Parts taken from
        # http://dex.localhost/.well-known/openid-configuration
        authUrl = "https://${dexUrl}/auth";
        tokenUrl = "http://${dexUrl}/token";
        userinfoUrl = "http://${dexUrl}/userinfo";
        clientId = "outline";
        clientSecretFile = dexOutlineSecretFile;
        scopes = ["openid" "email" "profile"];
        usernameClaim = "preferred_username";
        displayName = "Dex";
      };
    };

    dex = {
      enable = true;
      settings = {
        issuer = "https://${dexUrl}";
        storage.type = "sqlite3";
        web.http = "127.0.0.1:${toString dexPort}";
        enablePasswordDB = true;
        staticClients = [
          {
            id = "outline";
            name = "Outline Client";
            redirectURIs = ["https://${outlineUrl}/auth/oidc.callback"];
            secretFile = dexOutlineSecretFile;
          }
        ];
        staticPasswords = [
          {
            email = "oscar@eldolfin.top";
            # bcrypt hash of the string "password": $(echo password | htpasswd -BinC 10 admin | cut -d: -f2)
            hash = "$2y$10$y9q6O0yEQ1xD6XWjT9ifAe6zvIfscpuzenQQAH5k1HQYthrKSOJsm";
            username = "oscar";
            # easily generated with `$ uuidgen`
            userID = "e447cb79-56ed-42b1-8d04-1c9e453b2d81";
          }
        ];
      };
    };
    caddy = {
      enable = true;
      virtualHosts = {
        "https://${outlineUrl}" = {
          extraConfig = ''
            tls internal
            reverse_proxy localhost:${toString outlinePort}
          '';
        };
        "https://${dexUrl}" = {
          extraConfig = ''
            tls internal
            reverse_proxy localhost:${toString dexPort}
          '';
        };
      };
    };
  };
}
