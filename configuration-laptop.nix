# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [
        <nixos-hardware/dell/xps/15-9560/nvidia>
            /etc/nixos/git-repo/common.nix
        ];


# Wifi EPITA
   # networking = {
   #     interfaces = {
   #         wlp59s0.ipv4.addresses = [{
   #             prefixLength = 64;
   #         }];
   #     };
   #     wireless.networks.IONIS.auth = ''
   #         eap=PEAP
   #         identity="oscar.le-dauphin@epita.fr"
   #         password="vnzpeBAL"
   #         '';
   # };

    networking.hostName = "nixos-portable"; # Define your hostname.
        services.xserver.layout = "us";
# for firefox to support touchscreen scroll
    environment.sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
    };


# Optionally, you may need to select the appropriate driver version for your specific GPU.
# hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.prime = {

# Make sure to use the correct Bus ID values for your system!
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };

    services.illum.enable = true;

# lol (800MHz)
# powerManagement.cpufreq.max = 800;

# Enable the OpenSSH daemon.
    services.openssh.enable = false;

# touchscreen maybe
    services.xserver.synaptics = {
        enable = true;
        twoFingerScroll = true;
        maxSpeed = "4.0";
        scrollDelta = -75;
    };

    services.xserver.dpi = 400;

    services.xserver.libinput.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.11"; # Did you read the comment?
}
