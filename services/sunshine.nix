_: {
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "1080p Desktop";
          # prep-cmd = [
          #   {
          #     do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DVI-D-0.mode.1920x1080@60";
          #     undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DVI-D-0.mode.1920x1200@60";
          #   }
          # ];
          # exclude-global-prep-cmd = "false";
          # auto-detach = "true";
        }
      ];
    };
    settings = {
      output_name = 1;
    };
  };
  systemd.user.services.sunshine = {
    wantedBy = ["multi-user.target"];
  };
}
