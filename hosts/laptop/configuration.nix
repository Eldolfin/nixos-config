{ pkgs, ... }:
{
  imports = [
    ../../common.nix
    ../../services/autocpufreq.nix
    ../../pkgs/systemd-boot.nix
  ];
  networking.hostName = "oscar-portable";
  services = {
    openssh.enable = false;
    xserver = {
      xkb.layout = "gb";
    };
    displayManager.autoLogin.enable = false;
  };

  environment.systemPackages = with pkgs; [ brightnessctl ];
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # lol (800MHz)
  # powerManagement.cpufreq.max = 800;

  system.stateVersion = "22.11";
}
