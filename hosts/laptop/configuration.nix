{
  imports = [
    ../../services/autocpufreq.nix
    ../../pkgs/systemd-boot.nix
  ];
  networking.hostName = "oscar-portable";
  console.keyMap = "uk";
  services = {
    openssh.enable = false;
    xserver.xkb.layout = "gb";
    # tlp.enable = true;
    # touchegg.enable = true;
  };
}
