{
  config,
  lib,
  pkgs,
  system,
  ...
}:
let
  mod = "Mod1";

  svg = system.icons.svg config.colors.foreground;
  powerMenu = {
    prompt = "System power menu";
    colors = config.colors;
    options = with system.icons.set; [
      {
        label = "Lock";
        icon = svg md-lock;
        command = "${config.lock.cmd}";
      }
      {
        label = "Sleep";
        icon = svg md-sleep;
        command = "systemctl suspend";
      }
      {
        label = "Hibernate";
        icon = svg md-snowflake;
        command = "systemctl hibernate";
      }
      {
        label = "Restart";
        icon = svg md-restart;
        command = "systemctl restart";
      }
      {
        label = "Shutdown";
        icon = svg md-power;
        command = "systemctl poweroff";
      }
    ];
  };
  displayMenu = {
    prompt = "External display";
    colors = config.colors;
    options = with system.icons.set; [
      {
        label = "Laptop";
        icon = svg md-laptop;
        command = "autorandr default";
      }
      {
        label = "Extend";
        icon = svg md-panorama_horizontal;
        command = "autorandr horizontal";
      }
      {
        label = "Clone";
        icon = svg md-monitor_multiple;
        command = "autorandr common";
      }
    ];
  };
  wm_config = {
    modifier = mod;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    bars = [ ];

    gaps = {
      inner = 10;
      outer = 5;
    };

    focus = {
      followMouse = false;
    };

    window.titlebar = false;
    window.border = config.style.stroke-width;

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
      "${mod}+w" = "workspace 0:W";
      "${mod}+Shift+w" = "move container to workspace 0:W";

      "${mod}+d" = "exec rofi -show combi";

      "Mod4+l" = "exec ${config.lock.cmd}";
      "${mod}+Tab" = "workspace back_and_forth";

      # Framework F keys
      XF86AudioMute = "exec --no-startup-id ${config.volume.mute}";
      XF86AudioLowerVolume = "exec --no-startup-id ${config.volume.down}";
      XF86AudioRaiseVolume = "exec --no-startup-id ${config.volume.up}";
      XF86AudioPrev = "exec --no-startup-id ${pkgs.mpc}/bin/mpc prev";
      XF86AudioPlay = "exec --no-startup-id ${pkgs.mpc}/bin/mpc toggle";
      XF86AudioNext = "exec --no-startup-id ${pkgs.mpc}/bin/mpc next";
      XF86MonBrightnessDown = "exec --no-startup-id ${config.brightness.down}";
      XF86MonBrightnessUp = "exec --no-startup-id ${config.brightness.up}";
      "Mod4+p" = "exec --no-startup-id ${pkgs.mkMenu displayMenu}/bin/display";
      XF86RFKill = "";
      Print = "exec --no-startup-id ${pkgs.maim}/bin/maim -s ~/maim-$(date +%s).png";
      XF86AudioMedia = "";

      XF86Sleep = "exec --no-startup-id ${pkgs.mkMenu powerMenu}/bin/display";
      XF86PowerOff = "exec --no-startup-id ${pkgs.mkMenu powerMenu}/bin/display";
    };

    assigns = {
      "0:W" = [ { app_id = "firefox"; } ];
    };

    colors =
      let
        common = {
          border = config.colors.background-hl;
          text = config.colors.foreground;
          background = config.colors.background;
        };
      in
      {
        # Border: Color of the border between the titlebar and the window
        # Background: Color of the titlebar background
        # Text: Color of foreground text in the titlebar
        # ChildBorder: Color of the border around the window
        # Indicator: The border of the window where a new child will be placed.
        focused = {
          indicator = config.colors.focus-accent;
          childBorder = config.colors.foreground;
        }
        // common;

        # Windows that have focus not in the active container
        focusedInactive = {
          indicator = config.colors.foreground;
          childBorder = config.colors.foreground;
        }
        // common;

        # All other unfocused windows
        unfocused = {
          indicator = config.colors.secondary;
          childBorder = config.colors.secondary;
        }
        // common;

        urgent = {
          text = config.colors.urgent;
          indicator = config.colors.urgent;
          childBorder = config.colors.urgent;
        }
        // common;

        placeholder = {
          indicator = config.colors.secondary;
          childBorder = config.colors.secondary;
        }
        // common;

        background = config.colors.background;
      };
  };
in
{
  imports = [
    ./lock
    ./brightvol
  ];

  # Auto launch sway on first boot
  #programs.fish.loginShellInit = ''
  #[[ "$(tty)" == /dev/tty1 ]] && sway
  #'';

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = "wlr";
    };
  };

  #environment.pathsToLink = [
  #"/share/xdg-desktop-portal"
  #"/share/applications"
  #];

  wayland.windowManager.sway = {
    package = pkgs.swayfx;
    checkConfig = false;
    enable = true;
    config = wm_config // {
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "disabled";
          click_method = "clickfinger";
        };
        "type:keyboard" = {
          xkb_options = "caps:escape";
        };
      };
      output = {
        "*" = {
          bg = "${../../../../resources/wallpaper/wallpaper.png} fill";
          scale = "1.5";
        };
      };
    };
    extraConfig = ''
      bindswitch lid:on output eDP-1 disable
      bindswitch lid:off output eDP-1 enable

      default_dim_inactive 0.1
      corner_radius 0
      shadows enable
      blur enable
      shadow_blur_radius 10
      shadow_inactive_color #00000000

      ${builtins.concatStringsSep "\n" (
        builtins.map
          (layer: ''
            layer_effects "${layer}" {
              blur enable;
              blur_xray disable;
              blur_ignore_transparent enable;
              shadows enable;
            }
          '')
          [
            "notifications"
            "waybar"
            "rofi"
          ]
      )}

      workspace 1
    '';
  };
}
