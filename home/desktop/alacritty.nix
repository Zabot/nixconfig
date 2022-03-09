{ config, lib, pkgs, ... }:
with (import ./solarized.nix); {
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
          background = semantic.background;
          foreground = semantic.foreground;
        };

        normal = {
          black =   colors.base02;
          white =   colors.base2;
          yellow =  colors.yellow;
          red =     colors.red;
          magenta = colors.magenta;
          blue =    colors.blue;
          cyan =    colors.cyan;
          green =   colors.green;
        };

        bright = {
          black =   colors.base03;
          green =   colors.base01;
          yellow =  colors.base00;
          blue =    colors.base0;
          cyan =    colors.base1;
          white =   colors.base3;
          red =     colors.orange;
          magenta = colors.violet;
        };
      };
    };
  };
}
