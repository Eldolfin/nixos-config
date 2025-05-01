{pkgs, ...}: {
  home.packages = with pkgs; [
    # enabled as a service but the package is needed too for the command to be available in PATH
    wlsunset
  ];

  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            interval = 1;
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
          }
          {
            block = "net";
          }
          {
            block = "temperature";
            chip = "*-isa-*";
          }
          {
            block = "battery";
            format = " $icon $percentage {$time_remaining.dur(hms:true, min_unit:m) |}";
            missing_format = "";
          }
          {
            block = "sound";
          }
          {
            block = "hueshift";
          }
          {
            block = "time";
            interval = 1;
            format = " $timestamp.datetime(f:'%a %d/%m %T') ";
          }
          {
            block = "notify";
            format = " $icon {($notification_count.eng(w:1)) |}";
            driver = "swaync";
            click = [
              {
                button = "left";
                action = "show";
              }
              {
                button = "right";
                action = "toggle_paused";
              }
            ];
          }
        ];
        icons = "material-nf";
        theme = "ctp-frappe";
      };
    };
  };
}
