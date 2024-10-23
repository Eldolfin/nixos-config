{pkgs, ...}: {
  environment.systemPackages = [pkgs.niri];
  services.displayManager.sessionPackages = [pkgs.niri];
}
