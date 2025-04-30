{
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
            block = "sound";
          }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %T') ";
          }
          {
            block = "hueshift";
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
        icons = "emoji";
        theme = "ctp-frappe";
      };
    };
  };
}
