@default:
  just --list

# Runs all tests one by one
ci:
    #!/usr/bin/env bash
    set -e
    TESTS=$(nix flake show --all-systems --json | jq -r '.checks."x86_64-linux" | keys[]')
    printf "\033[1;34mRunning tests: \033[1;33m%s\033[0m\n" "[$(echo "$TESTS" | paste -sd, -)]"
    for test in $TESTS; do
        printf "\033[1;34mRunning test \033[1;33m%s\033[0m\n" "$test"
        nix build .#checks.x86_64-linux.$test
    done

# Runs all tests in parallel, which causes an OOM on CI
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
    nixos-rebuild switch --flake '/etc/nixos#oscar-portable' --show-trace --build-host oscar@192.168.1.167 |& nom
