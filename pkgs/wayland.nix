{ pkgs, ... }: {
  imports = [ ./sddm.nix ];
  environment.systemPackages = with pkgs; [ swaylock ];
  programs.sway.enable = true;
  # programs.sway.package = pkgs.swayfx;
}
