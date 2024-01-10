# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/git-repo/common.nix
    ];

  networking.hostName = "nixos-portable";
  networking.wireless.enable = true;
  services = {
    illum.enable = true;
    openssh.enable = false;
    xserver = {
      libinput.enable = false;
      layout = "gb";
      displayManager.autoLogin.enable = false;
      displayManager.gdm.enable = true;
    };
  };
  # lol (800MHz)
  # powerManagement.cpufreq.max = 800;

  # for firefox to support touchscreen scroll
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # touchscreen maybe
  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    maxSpeed = "4.0";
    scrollDelta = -75;
  };


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
  #         password="#####"
  #         '';
  # };

  system.stateVersion = "22.11";
}
