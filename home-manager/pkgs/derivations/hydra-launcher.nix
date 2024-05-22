{
    pkgs ? import (fetchTarball{
            url= "https://github.com/NixOS/nixpkgs/archive/9a9960b98418f8c385f52de3b09a63f9c561427a.tar.gz";
            sha256 =  "0nf2h21vbzfccpl7pq52igga4xqpa12jadsxic4cr4z424w1dps7";
            }) {}
}:
pkgs.stdenv.mkDerivation rec {
    name = "hydra-launcher";

    src = pkgs.fetchgit {
        url = "https://github.com/hydralauncher/hydra";
        rev = "v1.1.0";
        sha256 = "sha256-Fo6zYjYCSiWHsNvZcmgj3j4cIvLZD1MILBCJeSS2yy4=";
    };

    buildInputs = [ pkgs.python39 pkgs.nodejs pkgs.yarn ];

    configurePhase = ''
        yarn
        pip install -r requirements.txt
    '';

    buildPhase = ''
        yarn make
    '';

    # installPhase = ''
    #     mkdir -p $out/bin
    #     cp -r build/* $out/bin
    # '';
}
