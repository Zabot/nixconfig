{ config, lib, pkgs, ... }:
let
  mod = "Mod1";
in with (import ./solarized.nix); {
  imports = [
    ./polybar.nix
    ./autorandr.nix
    ./dunst.nix
  ];
  programs.rofi.enable = true;

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = mod;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      bars = [];

      gaps = {
        inner = 10;
        outer = 10;
      };

      focus = {
        followMouse = false;
      };

      window.titlebar = false;

      keybindings = lib.mkOptionDefault {
        "${mod}+F4" = "kill";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+w" = "workspace WWW";
        "${mod}+Shift+w" = "move container to workspace WWW";

        "${mod}+d" = "exec rofi -show run";

        XF86MonBrightnessUp = "exec --no-startup-id xbacklight -inc 10";
        XF86MonBrightnessDown = "exec --no-startup-id xbacklight -dec 10";
      };

      assigns = {
        "WWW" = [
          {class = "(?i)firefox";}
        ];
      };

      colors = {
        focused = {
          border = colors.debug;
          background = colors.base02;
          text = colors.base0;
          indicator = colors.green;
          childBorder = colors.yellow;
        };

        focusedInactive = {
          border = colors.debug;
          background = colors.base03;
          text = colors.base0;
          indicator = colors.green;
          childBorder = colors.base01;
        };

        unfocused = {
          border = colors.debug;
          background = colors.debug;
          text = colors.base01;
          indicator = colors.debug;
          childBorder = colors.base01;
        };

        urgent = {
          border = colors.debug;
          background = colors.base03;
          text = colors.red;
          indicator = colors.debug;
          childBorder = colors.red;
        };

        placeholder = {
          border = colors.debug;
          background = colors.debug;
          text = colors.base0;
          indicator = colors.debug;
          childBorder = colors.debug;
        };

        background = colors.debug;
      };
    };
  };
}
