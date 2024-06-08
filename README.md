# My nixos system config

## I somehow broke my system again (run one by one)
```bash
sudo -i
````
then
```bash
# replace with partition names
mount /dev/disk/by-label/NIXROOT /mnt/
mount /dev/disk/by-label/NIXBOOT /mnt/boot/

nixos-install --flake '/mnt/etc/nixos/flake.nix#oscar-portable' # replace with correct host
```