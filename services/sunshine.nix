{ config, pkgs, ... }:
{
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
  };
  systemd.user.services.sunshine = {
    wantedBy = [ "multi-user.target" ];
  };
}
