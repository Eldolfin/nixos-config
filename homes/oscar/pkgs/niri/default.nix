{
  pkgs,
  lib,
  config,
  isTour,
  ...
}: {
  # TODO:
  # - make clipse class window floating
  home.packages = with pkgs; [
    grim
    slurp
    swappy
  ];
  programs.niri.settings = with config.lib.niri.actions; let
    lockAction = spawn "swaylock";
  in {
    switch-events.lid-close.action = lockAction;
    prefer-no-csd = true; # aka hide window decoration
    spawn-at-startup = [
      {command = ["waybar"];}
      {command = ["${lib.getExe' pkgs.planify "io.github.alainm23.planify"}" "-b"];}
    ];
    input = {
      focus-follows-mouse.enable = true;
      # wrap-mouse-to-focus.enable = true;
      touchpad = {
        click-method = "clickfinger"; # two finger right click
      };
      keyboard = {
        numlock = true;
        repeat-delay = 250;
        repeat-rate = 50;
        xkb = {
          layout =
            if isTour
            then "fr"
            else "gb";
          options = "caps:escape";
        };
      };
    };
    layout = {
      focus-ring.width = 2;
      always-center-single-column = true;
    };
    binds = let
      sh = spawn "sh" "-c";
    in {
      "Mod+D".action.spawn = "fuzzel";
      "Mod+V".action.spawn = ["kitty" "--class=clipse" "-e" "pkgs.clipse"];
      "Print".action = sh ''grim -g "$(slurp)" - | swappy -f - -o - | wl-copy'';

      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
    };
  };
}
