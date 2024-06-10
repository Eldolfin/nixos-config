{
  imports = [
    ./cri-sddm.nix
  ];
  services.displayManager =
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
  cri.sddm = {
    enable = true;
    # theme = "epita-acu-2024"; 
  };
}
