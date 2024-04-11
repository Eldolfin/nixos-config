{
  imports = [
    ./cri-sddm.nix
  ];
  services.xserver =
    {
      enable = true;
      displayManager =
        {
          sddm = {
            enable = true;
            autoNumlock = true;
            settings = {
              General = {
                InputMethod = "";
              };
            };
          };
        };
    };
  cri.sddm = {
    enable = true;
    # theme = "epita-acu-2024"; 
  };
}
