{ ... }:

{
  boot.loader = {
    # systemd-boot.enable = true;

    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = [ "nodev" ];
      extraEntriesBeforeNixOS = false;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';

      darkmatter-theme = {
        enable = true;
        style = "nixos";
        icon = "color";
        resolution = "1080p";
      };
    };

    efi = {
      # canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
