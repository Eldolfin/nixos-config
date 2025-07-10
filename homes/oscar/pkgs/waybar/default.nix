{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      # "layer"= "top"; # Waybar at top layer
      # "position"= "bottom"; # Waybar position (top|bottom|left|right)
      "height" = 30; # Waybar height (to be removed for auto height)
      # "width"= 1280; # Waybar width
      "spacing" = 4; # Gaps between modules (4px)
      # Choose the order of the modules
      "modules-left" = [
        "niri/window"
        "niri/workspaces"
      ];
      "modules-center" = [
        "sway/window"
      ];
      "modules-right" = [
        "network"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "sway/language"
        "battery"
        "battery#bat2"
        "clock"
        "tray"
        "custom/power"
      ];
      # Modules configuration
      "niri/workspaces" = {
        "format" = "{icon}";
        "format-icons" = {
          # Named workspaces
          # (you need to configure them in niri)
          "browser" = "";
          "discord" = "";
          "chat" = "<b></b>";
          # Icons by state
          "active" = "";
          "default" = "";
        };
      };
      "niri/window" = {
        "max-length" = 50;
        "rewrite" = {
          "(.*) .+ Mozilla Firefox" = "🌎 $1";
          "hx (.*)" = " $1";
        };
      };
      "tray" = {
        # "icon-size"= 21;
        "spacing" = 10;
        # "icons"= {
        #   "blueman"= "bluetooth";
        #   "TelegramDesktop"= "$HOME/.local/share/icons/hicolor/16x16/apps/telegram.png"
        # }
      };
      "clock" = {
        "tooltip-format" = "<big>{=%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format" = "{=%Y-%m-%d %H=%M=%S}";
        "interval" = 1;
      };
      "cpu" = {
        "format" = "{usage}% ";
        "tooltip" = false;
      };
      "memory" = {
        "format" = "{}% ";
      };
      "temperature" = {
        # "thermal-zone"= 2;
        # "hwmon-path"= "/sys/class/hwmon/hwmon2/temp1_input";
        "critical-threshold" = 80;
        # "format-critical"= "{temperatureC}°C {icon}";
        "format" = "{temperatureC}°C {icon}";
        "format-icons" = [
          ""
          ""
          ""
        ];
      };
      "backlight" = {
        # "device"= "acpi_video1";
        "format" = "{percent}% {icon}";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
      };
      "battery" = {
        "states" = {
          # "good"= 95;
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-full" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        # "format-good"= ""; # An empty format will hide the module
        # "format-full"= "";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
      "battery#bat2" = {
        "bat" = "BAT2";
      };
      "network" = {
        # "interface"= "wlp2*"; # (Optional) To force the use of this interface
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} 󰈀";
        "tooltip-format" = "{ifname} via {gwaddr}";
        "format-linked" = "{ifname} (No IP)";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}= {ipaddr}/{cidr}";
      };
      "custom/power" = {
        "format" = "⏻ ";
        "tooltip" = false;
        "menu" = "on-click";
        "menu-file" = "$HOME/.config/waybar/power_menu.xml"; # Menu file in resources folder
        "menu-actions" = {
          "shutdown" = "shutdown";
          "reboot" = "reboot";
          "suspend" = "systemctl suspend";
          "hibernate" = "systemctl hibernate";
        };
      };
    };
    style = import ./style.css;
  };
}
