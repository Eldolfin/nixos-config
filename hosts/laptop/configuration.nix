{ pkgs, ... }:
{
  imports = [
    ../../common.nix
    ../../services/autocpufreq.nix
    ../../pkgs/systemd-boot.nix
    # ../../pkgs/niri.nix
  ];
  networking.hostName = "oscar-portable";
  services = {
    openssh.enable = false;
    xserver = {
      xkb.layout = "gb";
    };
    displayManager.autoLogin.enable = true; # TODO: remove later
    tlp.enable = true;
  };

  environment.systemPackages = with pkgs; [ brightnessctl ];

  system.stateVersion = "22.11";
}
