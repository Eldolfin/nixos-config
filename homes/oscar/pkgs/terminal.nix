{
  pkgs,
  lib,
  isTour,
  ...
}:
let
  termFontSize = if isTour then 22 else 12;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = lib.mkForce termFontSize;
      bell = {
        command = {
          program = "${pkgs.pulseaudio}/bin/paplay";
          args = [ "/home/oscar/Music/sounds/Tink.wav" ];
        };
        duration = 30;
      };
    };
  };
  # programs.wezterm.enable = true;
  home.packages = with pkgs; [
    # kitty
    cool-retro-term
  ];
}
