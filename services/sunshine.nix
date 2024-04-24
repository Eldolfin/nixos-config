{config, pkgs, ... }:
{
    services.sunshine={
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
    };
    services.avahi.publish.enable = true;
    services.avahi.publish.userServices = true;
}
