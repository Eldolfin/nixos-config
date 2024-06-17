{ pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
  };
  programs.i3blocks = {
    enable = true;
    bars = {
      bottom = {
        time = {
          command = "date +%r";
          interval = 1;
        };
        # Make sure this block comes after the time block
        date = lib.hm.dag.entryAfter [ "time" ] {
          command = "date +'%a %d/%m/%Y'";
          interval = 60;
        };
        # And this block after the example block
        volume = lib.hm.dag.entryAfter [ "date" ] {
          command = "~/.config/i3/scripts/i3-volume/volume output i3blocks";
          interval = "once";
          signal = 10;
          label = "VOL";
        };
        cpu = lib.hm.dag.entryAfter [ "volume" ] {
          command = "~/.config/i3blocks/scripts/cpu_usage";
          interval = "10";
          label = "CPU";
          min_width = "100.00%";
        };
        memory = lib.hm.dag.entryAfter [ "cpu" ] {
          command = "~/.config/i3/scripts/i3memory";
          interval = "5";
          label = "MEM";
        };
      };
    };
  };
  programs.swaylock.enable = true;

  xsession.numlock.enable = true;

  home.packages = with pkgs; [
    # rofi-bluetooth # useless
    i3lock-fancy-rapid
    rofi-power-menu
    slock
    picom
    wl-clipboard-rs
    swaybg
  ];
}
