{
  lib,
  pkgs,
  ...
}: {
  services = {
    avizo.enable = true;
    swaync = {
      enable = true;
    };
    wlsunset = {
      enable = true;
      latitude = 48.864716;
      longitude = 2.349014;
    };
  };
  systemd.user.services = {
    awatcher = {
      Service = {
        Type = "simple";
        TimeoutStartSec = "120";
        ExecStartPre = "/bin/sleep 5";
        ExecStart = "${lib.getExe pkgs.awatcher}";
        Restart = "always";
        RestartSec = "5";
        RestartSteps = "2";
        RestartMaxDelaySec = "15";
      };
      Unit = {
        Description = "Free time tracker";
        After = ["graphical-session.target"];
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
