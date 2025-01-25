@default:
  just --list

test:
    nix flake check -L

_deploy NIX_HOSTNAME SSH_HOSTNAME:
    nixos-rebuild switch --use-remote-sudo --build-host localhost --target-host {{SSH_HOSTNAME}} --flake ".#{{NIX_HOSTNAME}}" |& nom

deploy-oracle-x86: (_deploy "oracle-x86" "oracle-x86.eldolfin.top")
deploy-homeserver: (_deploy "homeserver" "192.168.1.71")
