{
  imports = [
    (
      let rev = "main"; in
      import (builtins.fetchTarball {
        url = "https://gitlab.com/VandalByte/darkmatter-grub-theme/-/archive/${rev}/darkmatter-grub-theme-${rev}.tar.gz";
        sha256 = "1i6dwmddjh0cbrp6zgafdrji202alkz52rjisx0hs1bgjbrbwxdj";
      })
    )
  ];
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
        enable = false;
        style = "nixos";
        icon = "color";
        resolution = "1080p";
      };
    };
  };
}
