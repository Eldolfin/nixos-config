# My nixos system config [![CI](https://github.com/Eldolfin/nixos-config/actions/workflows/ci.yml/badge.svg)](https://github.com/Eldolfin/nixos-config/actions/workflows/ci.yml)

## Screenshot

Integration tests are ran on github actions, checkout the commit history
[here](https://eldolfin.github.io/nixos-config)
![Latest screenshots of my system](https://github.com/Eldolfin/nixos-config/blob/gh-pages/latest.png)

## Misc

### I somehow broke my system again (run one by one)

```bash
sudo -i
```

then

```bash
# replace with partition names
mount /dev/disk/by-label/NIXROOT /mnt/
mount /dev/disk/by-label/NIXBOOT /mnt/boot/

nixos-install --flake '/mnt/etc/nixos/flake.nix#oscar-portable' # replace with correct host
```
