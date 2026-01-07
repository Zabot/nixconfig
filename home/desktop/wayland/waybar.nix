{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  programs.waybar = lib.mkIf config.desktop.useWayland {
    enable = true;
    systemd = {
      enable = true;
    };
    style = pkgs.replaceVars ./waybar.css {
      background = system.colors.background;
      background-hl = system.colors.background-hl;
      foreground = system.colors.foreground;
      focus = system.colors.focus;
    };
    settings = rec {
      "bar/primary" = {
        position = "bottom";

        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ ];
        modules-right = [
          "wireplumber"

          "network"
          "backlight"
          "battery"
          "clock"
        ];

        "sway/workspaces" = {
          numeric-first = false;
        };

        battery = {
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        network = {
          format = "{ifname}";
          format-wifi ="{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "disconnected";
          tooltip-format = "{ifname} {ipaddr}/{cidr} via {gwaddr}";
          #tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          #tooltip-format-ethernet = "{ifname} ";
          #tooltip-format-disconnected = "Disconnected";
          # max-length = 50;
        };

        backlight = {
          format-icons = with system.icons.set; [
            mdi-brightness_5.char
            mdi-brightness_6.char
            mdi-brightness_6.char
            mdi-brightness_7.char
          ];
          format = "{icon} {percent}%";
        };

        clock = {
          format = "{:%H:%M}  ";
          format-alt = "{:%A, %B %d, %Y (%R)}  ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          #actions =  {
                      #"on-click-right": "mode",
                      #"on-scroll-up": "tz_up",
                      #"on-scroll-down": "tz_down",
                      #"on-scroll-up": "shift_up",
                      #"on-scroll-down": "shift_down"
                      #}
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          on-click = "${pkgs.helvum}/bin/helvum";
          format-icons = with system.icons.set; [
            mdi-volume_low.char
            mdi-volume_medium.char
            mdi-volume_high.char
          ];
        };
      };



    };
  };
}
