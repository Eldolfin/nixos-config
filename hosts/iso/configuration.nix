{ modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.wireless.enable = false;

  services.displayManager.sddm.settings.Autologin = {
    Session = "none+i3";
    User = "nixos";
  };
}
