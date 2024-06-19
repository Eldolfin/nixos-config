{ config, pkgs, ... }:
{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      47984
      47989
      47990
      48010
    ];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
  };
  systemd.user.services.sunshine = {
    # description = "Sunshine self-hosted game stream host for Moonlight";
    startLimitBurst = 5;
    startLimitIntervalSec = 500;
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      # ExecStart = "${config.security.wrapperDir}/sunshine";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  # not sure this is needed
  # security.wrappers.sunshine = {
  #   owner = "root";
  #   group = "root";
  #   capabilities = "cap_sys_admin+p";
  #   source = "${pkgs.sunshine}/bin/sunshine";
  # };
}
