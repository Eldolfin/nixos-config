{
  boot.loader = {
    systemd-boot.enable = true;

    # grub = {
    #   enable = true;
    #   useOSProber = true;
    #   efiSupport = true;
    #   efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
    #   devices = [ "nodev" ];
    #   extraEntriesBeforeNixOS = false;
    #   extraEntries = ''
    #     menuentry "Reboot" {
    #       reboot
    #     }
    #     menuentry "Poweroff" {
    #       halt
    #     }
    #   '';
    # };
  };
}
