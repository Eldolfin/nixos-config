@default:
  just --list

test:
    nix flake check -L

_deploy NIX_HOSTNAME SSH_HOSTNAME BUILD_HOSTNAME:
    nixos-rebuild switch --use-remote-sudo --build-host {{BUILD_HOSTNAME}} --target-host {{SSH_HOSTNAME}} --flake ".#{{NIX_HOSTNAME}}" |& nom

deploy-oracle-x86: (_deploy "oracle-x86" "oracle-x86.eldolfin.top" "localhost")
deploy-homeserver: (_deploy "homeserver" "192.168.1.71" "localhost")
deploy-homeserver-from-homeserver: (_deploy "homeserver" "192.168.1.71" "192.168.1.71")
deploy-local:
    nh os switch /etc/nixos

deploy-all: deploy-local deploy-homeserver deploy-oracle-x86

watch:
    git ls-files | entr -c nh os switch /etc/nixos

build-laptop-on-tour:
    nixos-rebuild switch --flake '/etc/nixos#oscar-portable' --show-trace --build-host oscar@192.168.1.71 |& nom
