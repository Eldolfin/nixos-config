{pkgs, ...}: {
  services = {
    activitywatch = {
      enable = true;
      watchers = {
        aw-watcher-afk = {
          package = pkgs.activitywatch;
          settings = {
            timeout = 300;
            poll_time = 2;
          };
        };

        aw-watcher-windows = {
          package = pkgs.activitywatch;
          settings = {
            poll_time = 1;
            exclude_title = true;
          };
        };
      };
    };
  };
}
