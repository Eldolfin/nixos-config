{
  imports = [
    ../../common.nix
    ../../services/autocpufreq.nix
    ../../pkgs/systemd-boot.nix
  ];
  networking.hostName = "oscar-portable";
  # networking.wireless.enable = true;
  services = {
    openssh.enable = false;
    xserver = {
      xkb.layout = "gb";
    };
    displayManager.autoLogin.enable = false;
  };
  # lol (800MHz)
  # powerManagement.cpufreq.max = 800;

  system.stateVersion = "22.11";
}
