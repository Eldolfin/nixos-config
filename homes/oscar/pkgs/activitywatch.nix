{
  pkgs,
  lib,
  ...
}: {
  services = {
    activitywatch = {
      enable = true;
      watchers = {
        # redundant with awatcher?
        # aw-watcher-afk = {
        #   package = pkgs.activitywatch;
        #   settings = {
        #     timeout = 300;
        #     poll_time = 2;
        #   };
        # };

        # aw-watcher-windows = {
        #   package = pkgs.activitywatch;
        #   settings = {
        #     poll_time = 1;
        #     exclude_title = true;
        #   };
        # };

        awatcher = {
          package = pkgs.awatcher;
          settings = {
            idle-timeout-seconds = 180;
            poll-time-idle-seconds = 10;
            poll-time-window-seconds = 5;
          };
        };
      };
    };
  };
  # taken from https://github.com/meatcar/dots/blob/d801df48e8f046d8063e3994111ea0b310605e19/home-manager/modules/activitywatch/default.nix#L10
  systemd.user.services.activitywatch-watcher-awatcher = {
    Unit.Requires = ["activitywatch.service"];
    Service = {
      # delay start for activiywatch to spin up.
      ExecStartPre = "/run/current-system/sw/bin/sleep 5";
      # make fault-tolerant
      Restart = "always";
    };
  };

  # FIXME: workaround for https://github.com/nix-community/home-manager/issues/5988
  systemd.user.targets.activitywatch = {
    Unit.After = lib.mkForce ["graphical-session.target"];
    Install.WantedBy = lib.mkForce ["graphical-session.target"];
  };
}
