{
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  # };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true; # might be needed
  };
}
