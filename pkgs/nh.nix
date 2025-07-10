{isTour, ...}: {
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;

        extraArgs = let
          max_age =
            if isTour
            then "60d" # might as well use my 2To ssd
            else "7d";
        in "--keep-since ${max_age}";
        dates = "weekly";
      };
    };
    nix-index-database.comma.enable = true;
    fish.enable = true;
  };
}
