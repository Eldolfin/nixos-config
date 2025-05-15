pkgs:
pkgs.writeShellApplication {
  name = "lower-brightness-if-night";

  runtimeInputs = with pkgs; [
    brightnessctl
  ];

  text = ''
    currenttime=$(date +%H:%M)
    if [[ "$currenttime" > "23:00" ]] || [[ "$currenttime" < "06:30" ]]; then
      echo "DEBUG: $currenttime is considered night, setting brightness to minimum"
      brightnessctl set 1 > /dev/null
    else
      echo "DEBUG: $currenttime is considered day, not changing brightness"
    fi
  '';
}
