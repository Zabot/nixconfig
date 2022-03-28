{ config, lib, pkgs, system, ... }:
let
  i3lock-color = (pkgs.callPackage ./lock-color.nix) {};
  stripHex = name: color: (builtins.substring 1 6 color);
  colors = builtins.mapAttrs stripHex system.colors;
  lock = builtins.concatStringsSep " " [
    "${i3lock-color}/bin/i3lock-color"
    "-e -k --force-clock --pass-screen-keys"
    "-c ${colors.background}"
    "-C -i ${../../../resources/lock.png}"
    "--refresh-rate=60"

    "--inside-color=00000000"
    "--insidewrong-color=00000000"
    "--insidever-color=00000000"
    "--line-uses-inside"

    "--wrong-text=\"\""
    "--verif-text=\"\""
    "--noinput-text=\"\""

    "--ring-color=${colors.background-hl}"
    "--ringver-color=${colors.focus}"
    "--ringwrong-color=${colors.error}"
    "--keyhl-color=${colors.secondary}"
    "--bshl-color=${colors.secondary}"
    "--verif-color=${colors.focus}"
    "--wrong-color=${colors.error}"

    "--time-color=${colors.secondary}"
    "--time-font=Overpass"
    "--time-size=128"
    "--time-align=1"
    "--time-pos=\"30:h-90-30\""
    "--time-str=\"%H:%M %p\""

    "--date-color=${colors.secondary}"
    "--date-font=Overpass"
    "--date-size=90"
    "--date-align=1"
    "--date-str=\"%A %B %d\""
    "--date-pos=\"tx:h-30\""

    "--indicator"
    "--ind-pos=\"w/2-541:h/2\""
    "--radius 97"
    "--ring-width 6"
    "--polygon-sides=6"
    "--polygon-highlight=2"
  ];

  mod = "Mod1";
in
{
  imports = [
    ./target.nix
  ];

  programs.rofi.enable = true;
  programs.rofi.extraConfig = {
    combi-modi = "window,run";
    font = "Inconsolata-g for Powerline 12";
    # TODO Make a proper custom theme using the global colors
    theme = "solarized";
  };

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

        "${mod}+d" = "exec rofi -show combi";

        "Mod4+l" = "exec ${lock}";

        XF86MonBrightnessUp = "exec --no-startup-id xbacklight -inc 10";
        XF86MonBrightnessDown = "exec --no-startup-id xbacklight -dec 10";
      };

      assigns = {
        "WWW" = [
          {class = "(?i)firefox";}
        ];
      };

      colors = let common = {
          border = system.colors.background-hl;
          text = system.colors.foreground;
          background = system.colors.background;
        }; in {
        # Border: Color of the border between the titlebar and the window
        # Background: Color of the titlebar background
        # Text: Color of foreground text in the titlebar
        # ChildBorder: Color of the border around the window
        # Indicator: The border of the window where a new child will be placed.
        focused = {
          indicator = system.colors.focus-accent;
          childBorder = system.colors.focus;
        } // common;

        # Windows that have focus not in the active container
        focusedInactive = {
          indicator = system.colors.foreground;
          childBorder = system.colors.foreground;
        } // common;

        # All other unfocused windows
        unfocused = {
          indicator = system.colors.secondary;
          childBorder = system.colors.secondary;
        } // common;

        urgent = {
          text = system.colors.urgent;
          indicator = system.colors.urgent;
          childBorder = system.colors.urgent;
        } // common;

        placeholder = {
          indicator = system.colors.secondary;
          childBorder = system.colors.secondary;
        } // common;

        background = system.colors.background;
      };
    };
  };
}
