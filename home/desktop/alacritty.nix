{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 9;
      font.normal = {
        family = "Inconsolata-g for Powerline";
        style = "Regular";
      };

      colors = {
        primary = {
          background = system.colors.background;
          foreground = system.colors.foreground;
        };
      } // system.colors.termcolors;
    };
  };
}
