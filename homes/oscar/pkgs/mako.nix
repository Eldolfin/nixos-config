{
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 10000;
      on-notify = "exec mpv ~/Music/sounds/bell.mp3";
    };
  };
}
