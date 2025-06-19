{
  nixpkgs-old-gxml,
  system,
  ...
}: _: _: {
  inherit (nixpkgs-old-gxml.legacyPackages.${system}) gxml;
}
