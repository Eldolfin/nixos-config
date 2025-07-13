{
  imports = [
    ../../common.nix
    ../../services/autocpufreq.nix
    ../../pkgs/systemd-boot.nix
    ../../pkgs/plymouth.nix
  ];
  networking.hostName = "oscar-portable";
  console.keyMap = "uk";
  services = {
    openssh.enable = false;
    xserver.xkb.layout = "gb";
    displayManager.autoLogin.enable = false;
    tlp.enable = true;
    touchegg.enable = true;
  };
}
