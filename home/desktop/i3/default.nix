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
  displayMenu = {
    prompt = "External display";
    colors = system.colors;
    options = with system.icons.set; [
      {
        label = "Laptop";
        icon = svg mdi-laptop;
        command = "autorandr default";
      }
      {
        label = "Extend";
        icon = svg mdi-panorama_horizontal;
        command = "autorandr horizontal";
      }
      {
        label = "Clone";
        icon = svg mdi-monitor_multiple;
        command = "autorandr common";
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

  programs.rofi = {
    enable = true;
    # TODO Make a proper custom theme using the global colors
    theme = "solarized";
    extraConfig = {
      combi-modi = "window,run";
      font = "Inconsolata-g for Powerline 12";
    };
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
      window.border = 2;

      defaultWorkspace = "workspace number 1";
      workspaceOutputAssign = [
        {
          output = "primary";
          workspace = "1";
        }
        {
          output = "primary";
          workspace = "2";
        }
        {
          output = "primary";
          workspace = "3";
        }
        {
          output = "primary";
          workspace = "4";
        }
        {
          output = "primary";
          workspace = "5";
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${mod}+q" = "kill";

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

        XF86AudioMute = "exec --no-startup-id ${config.volume.mute}";
        XF86AudioLowerVolume = "exec --no-startup-id ${config.volume.down}";
        XF86AudioRaiseVolume = "exec --no-startup-id ${config.volume.up}";
        XF86AudioPrev = "exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc prev";
        XF86AudioPlay = "exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc toggle";
        XF86AudioNext = "exec --no-startup-id ${pkgs.mpc_cli}/bin/mpc next";
        XF86MonBrightnessDown = "exec --no-startup-id ${config.brightness.down}";
        XF86MonBrightnessUp = "exec --no-startup-id ${config.brightness.up}";
        "Mod4+p" = "exec --no-startup-id ${pkgs.mkMenu displayMenu}/bin/display";

        Print = "exec --no-startup-id ${pkgs.maim}/bin/maim -s ~/maim-$(date +%s).png";

        XF86Sleep = "exec --no-startup-id ${pkgs.mkMenu powerMenu}/bin/display";
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
