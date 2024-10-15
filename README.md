# My nixos system config [![CI](https://github.com/Eldolfin/nixos-config/actions/workflows/ci.yml/badge.svg)](https://github.com/Eldolfin/nixos-config/actions/workflows/ci.yml)

## I somehow broke my system again (run one by one)

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



## TODO
- get rid of .sh
- remove unused such as lazyvim
