{ config, lib, pkgs, system, ... }:
let
  mod = "Mod1";

  svg = system.icons.svg system.colors.foreground;
  powerMenu = {
    prompt = "System power menu";
    colors = system.colors;
    options = with system.icons.set; [
      {
        label = "Lock";
        icon = svg mdi-lock;
        command = "${config.lock.cmd}";
      }
      {
        label = "Sleep";
        icon = svg mdi-sleep;
        command = "systemctl suspend";
      }
      {
        label = "Hibernate";
        icon = svg mdi-snowflake;
        command = "systemctl hibernate";
      }
      {
        label = "Restart";
        icon = svg mdi-restart;
        command = "systemctl restart";
      }
      {
        label = "Shutdown";
        icon = svg mdi-power;
        command = "systemctl poweroff";
      }
    ];
  };
in
{
  imports = [
    ./target.nix
    ./lock
    ./brightvol
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

        "Mod4+l" = "exec ${config.lock.cmd}";

        XF86MonBrightnessUp = "exec --no-startup-id ${config.brightness.up}";
        XF86MonBrightnessDown = "exec --no-startup-id ${config.brightness.down}";
        XF86AudioRaiseVolume = "exec --no-startup-id ${config.volume.up}";
        XF86AudioLowerVolume = "exec --no-startup-id ${config.volume.down}";
        XF86AudioMute = "exec --no-startup-id ${config.volume.mute}";
        XF86PowerOff = "exec --no-startup-id ${pkgs.mkMenu powerMenu}/bin/display";
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
