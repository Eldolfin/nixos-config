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

  networking.hostName = "nixos-portable";
  boot.loader.efi.efiSysMountPoint = "/boot/EFI";
  networking.wireless.enable = true;
  services = {
    illum.enable = true;
    openssh.enable = false;
    xserver = {
      dpi = 200;
      libinput.enable = false;
      layout = "us";
      displayManager.autoLogin.enable = false;
    };
  };
  # lol (800MHz)
  # powerManagement.cpufreq.max = 800;

  # for firefox to support touchscreen scroll
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
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
