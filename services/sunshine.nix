{ config, pkgs, ... }:
{
  # networking.firewall = {
  #     enable = true;
  #     allowedTCPPorts = [ 47984 47989 47990 48010 ];
  #     allowedUDPPortRanges = [
  #         { from = 47998; to = 48000; }
  #         { from = 8000; to = 8010; }
  #     ];
  # };
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
  services.sunshine = {
    openFirewall = true;
    description = "Sunshine self-hosted game stream host for Moonlight";
    startLimitBurst = 5;
    startLimitIntervalSec = 500;
    serviceConfig = {
      ExecStart = "${config.security.wrapperDir}/sunshine";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
