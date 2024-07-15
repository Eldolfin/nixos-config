{ config, ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oscar/.config/sops/age/keys.txt";
    secrets = {
      "passwords/emails/epita".owner = config.user.users.oscar.name;
      "apis/COPILOT_API_KEY".owner = config.users.users.oscar.name;
    };
  };
}
