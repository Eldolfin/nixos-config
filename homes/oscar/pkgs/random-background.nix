{backgrounds, ...}: {
  services.random-background = {
    enable = true;
    imageDirectory = "${backgrounds}/";
  };
}
