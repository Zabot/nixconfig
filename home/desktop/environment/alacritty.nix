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
      font.size = 15;
      font.normal = {
        family = builtins.head config.fonts.fontconfig.defaultFonts.monospace;
        style = "Regular";
      };
      window = {
        opacity = config.style.opacity;
        blur = true;
      };

      colors = {
        primary = {
          background = config.colors.background;
          foreground = config.colors.foreground;
        };
      }
      // config.colors.termcolors;
    };
  };
}
