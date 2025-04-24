{
  pkgs,
  lib,
  ...
}: {
  programs = {
    rofi.terminal = lib.getExe pkgs.ghostty;
    wezterm = {
      enable = true;
    };
    ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        window-vsync = false;
        gtk-titlebar = false;
        keybind = [
          "ctrl+enter=unbind" # defaults to toggle fullscreen
        ];
      };
    };
    # alacritty = {
    #   enable = true;
    #   settings = {
    #     font.size = lib.mkForce (
    #       if isTour
    #       then 22
    #       else 12
    #     );
    #     bell = {
    #       command = {
    #         program = "${pkgs.pulseaudio}/bin/paplay";
    #         args = ["/home/oscar/Music/sounds/Tink.wav"];
    #       };
    #       duration = 30;
    #     };
    #   };
    # };
  };
  # programs.wezterm.enable = true;
  home.packages = with pkgs; [
    # kitty
    cool-retro-term
  ];
}
