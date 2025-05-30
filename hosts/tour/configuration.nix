{
  imports = [
    # ../../pkgs/plymouth.nix
    ../../pkgs/wol-agent.nix
    ../../pkgs/nvidia.nix
    ../../pkgs/incus.nix
  ];

  eldolfin.services.wol-agent.machine-name = "tour";
  networking.hostName = "oscar-tour";
  services = {
    xserver = {
      xkb.layout = "fr";
    };
    displayManager.autoLogin.enable = true;
    openssh.enable = true;
  };
  # hardware.ckb-next.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
}
