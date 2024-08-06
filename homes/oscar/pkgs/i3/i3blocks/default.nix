{ lib, ... }:
{
  home.file.".config/i3blocks/scripts" = {
    source = ./scripts;
    recursive = true;
  };
  programs.i3blocks = {
    enable = true;
    bars = {
      config = {
        time = {
          command = "date +%R:%S";
          interval = 1;
        };
        # lib.hm.dag.entryBefore
        # Makes sure this block comes after the time block
        # (the order is from right to left)
        date = lib.hm.dag.entryBefore [ "time" ] {
          command = "date +'%a %d/%m/%Y'";
          interval = 60;
        };
        volume = lib.hm.dag.entryBefore [ "date" ] {
          command = "~/.config/i3/scripts/i3-volume/volume output i3blocks";
          interval = 5;
          signal = 10;
          label = "VOL ";
          markup = "pango";
        };
        cpu = lib.hm.dag.entryBefore [ "volume" ] {
          command = "~/.config/i3blocks/scripts/cpu_usage";
          interval = "10";
          label = "CPU ";
          min_width = "100.00%";
        };
        memory = lib.hm.dag.entryBefore [ "cpu" ] {
          command = "echo $(~/.config/i3blocks/scripts/i3memory)";
          interval = "5";
          label = "MEM ";
        };
        disk = lib.hm.dag.entryBefore [ "memory" ] {
          command = "~/.config/i3blocks/scripts/i3disk";
          interval = "10";
          label = "HOME ";
        };
        bandwidth = lib.hm.dag.entryBefore [ "disk" ] {
          command = "~/.config/i3blocks/scripts/bandwidth";
          interval = "5";
          INLABEL = "";
          OUTLABEL = "";
        };
        battery = lib.hm.dag.entryBefore [ "bandwidth" ] {
          command = "~/.config/i3blocks/scripts/battery";
          interval = "5";
        };
      };
    };
  };
}
