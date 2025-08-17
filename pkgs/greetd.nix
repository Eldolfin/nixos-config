{
  pkgs,
  lib,
  isTour,
  config,
  ...
}: let
  initialNiriConfig = pkgs.writeText "greetd-niri-config" ''
    hotkey-overlay {
    	skip-at-startup
    }
    input {
    	keyboard {
    		track-layout "global"
    		repeat-delay 250
    		repeat-rate 50
    		xkb {
    			layout "${
      if isTour
      then "fr"
      else "gb"
    }"
    		}
    	}
    	touchpad {
    		tap
    		// dwt
    		natural-scroll
    		accel-speed 0.5
    		accel-profile "adaptive"
    		scroll-factor 1.2
    		scroll-method "two-finger"
    		tap-button-map "left-right-middle"
    		click-method "clickfinger"
    		// disabled-on-external-mouse
    		// middle-emulation
    	}
    	mouse {
    		natural-scroll
    		accel-speed 0.5
    		accel-profile "adaptive"
    		scroll-factor 1.0
    		scroll-method "no-scroll"
    	}
    }

    environment {
        GTK_USE_PORTAL "0"
        GDK_DEBUG "no-portals"
    }

    animations {
    	off
    }
    output "DP-1" {
        transform "normal"
        position x=1920 y=0
        mode "1920x1200@59.950000"
    }
    output "DP-3" {
        transform "normal"
        position x=0 y=0
        mode "1920x1080@143.996000"
    }

    binds {
    }

    layout {
    }

    spawn-at-startup "sh" "-c" "${lib.getExe pkgs.greetd.regreet}; niri msg action quit --skip-confirmation"
  '';
in {
  programs.regreet = {
    enable = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      initial_session =
        lib.mkIf
        config.services.displayManager.autoLogin.enable
        {
          command = "niri-session -l";
          inherit (config.services.displayManager.autoLogin) user;
        };
      default_session = {
        command = "niri -c ${initialNiriConfig}";
        user = "greeter";
      };
    };
  };
  assertions = [
    {
      assertion =
        config.services.displayManager.defaultSession == "niri";
      message = "niri is hardcoded here...";
    }
  ];
}
