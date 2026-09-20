{ pkgs, ... }:
{
  imports = [
    ./icons
    ./style
    ./environment
    ./browser
  ];

  colors = (import ./style/solarized.nix).dark;
  style = {
    stroke-width = 1;
    opacity = 1.0;
  };

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 35.0;
    longitude = -100.0;
  };

  #services.random-background.enable = true;
  #services.random-background.imageDirectory = "${../resources/wallpaper}";

  #services.poweralertd.enable = true;

}
