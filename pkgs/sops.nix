{ config, ... }:
{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oscar/.config/sops/age/keys.txt";
    secrets = {
      "apis/COPILOT_API_KEY".owner = config.users.users.oscar.name;
    };
  };
}
