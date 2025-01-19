{config, ...}: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oscar/.config/sops/age/keys.txt";
    secrets = {
      "apis/COPILOT_API_KEY".owner = config.users.users.oscar.name;
      "apis/CACHIX_AUTH_TOKEN".owner = config.users.users.oscar.name;
      "wireguard/oracle/privateKey" = {};
      "wireguard/oracle/presharedKey" = {};
    };
  };
}
