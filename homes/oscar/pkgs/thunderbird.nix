{
  programs.thunderbird = {
    enable = true;
    settings = {
      "privacy.donottrackheader.enabled" = true;
    };
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
  accounts.email.accounts = {
    epita = {
      address = "oscar.le-dauphin@epita.fr";
      flavor = "outlook.office365.com"; # not sure
      # might not be needed
      # thunderbird = {
      #   enable = true;
      #   profiles = ["default"];
      # };
    };
  };
}
