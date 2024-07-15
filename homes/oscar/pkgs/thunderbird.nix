{
  programs.thunderbird = {
    enable = true;
    settings = {
      "privacy.donottrackheader.enabled" = true;
    };
    profiles = {
      default = {
        name = "default";
        isDefault = true;
      };
    };
  };
}
