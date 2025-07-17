{
  config,
  lib,
  ...
}: {
  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
    autologinUser = with config.services.displayManager.autoLogin; lib.mkIf enable user;
  };
}
