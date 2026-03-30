{ pkgs, ... }:
{
  imports = [
    ./style
    ./environment
    ./browser
  ];

  colors = (import ./style/solarized.nix).dark;
  style = {
    stroke-width = 1;
  };
  #programs.rofi.enable = true;
  #services.imapnotify.enable = true;

  #services.random-background.enable = true;
  #services.random-background.imageDirectory = "${../resources/wallpaper}";

  #services.poweralertd.enable = true;
  #services.redshift = {
  #  enable = true;
  #  provider = "manual";
  #  latitude = 35.0;
  #  longitude = -100.0;
  #};

}
