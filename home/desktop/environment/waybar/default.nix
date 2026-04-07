{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  systemd.user.services.waybar.Service.Environment = [
    "PATH=${
      lib.makeBinPath [
        # These dependencies are required by the sink select rofi menu
        pkgs.bash
        pkgs.wireplumber
        pkgs.pipewire
        pkgs.jq
      ]
    }"
  ];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    style = pkgs.replaceVars ./waybar.css {
      background = config.colors.background;
      background-hl = config.colors.background-hl;
      foreground = config.colors.foreground;
      secondary = config.colors.secondary;
      focus = config.colors.focus;
      urgent = config.colors.urgent;
      ok = config.colors.ok;
      font = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
    };
    settings =
      with system.icons.set;
      with config.colors;
      rec {
        "bar/primary" = {
          position = "bottom";

          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];
          modules-right = [
            "mpd"
            "wireplumber"
            "backlight"
            "network"
            "cpu"
            "battery"
            "clock"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            format = "{name} {windows}";

            # Must be set but is unused
            # https://github.com/Alexays/Waybar/issues/3797
            window-format = "unused";
            format-window-separator = "|";
            window-rewrite-default = "{index}";
            window-rewrite = {
              "class<firefox>" = md-firefox.char;
              "class<Alacritty>" = md-console_line.char;
              "title<.*vim.*>" = custom-vim.char;
              "title<.*neomutt.*>" = md-email_outline.char;
            };
          };

          cpu = {
            interval = 5;
            format = "${oct-cpu.char}{icon} {avg_frequency} GHz";
            format-icons = [
              "▁"
              "▂"
              "▃"
              "▄"
              "▅"
              "▆"
              "▇"
              "█"
            ];
          };

          mpd = {
            format = "{stateIcon} {title}";
            on-click = "/run/current-system/sw/bin/echo";
            format-stopped = "";

            tooltip-format = "{artist}\n{album}\n{title}\n{elapsedTime:%M:%S}/{totalTime:%M:%S}";

            random-icons = {
              off = md-shuffle_disabled.char;
              on = md-shuffle_variant.char;
            };

            state-icons = {
              paused = md-music_off.char;
              playing = md-music.char;
            };

            interval = 10;
          };

          battery = {
            states = {
              warning = 30;
              critical = 10;
            };
            format = "{icon} {power:.2} W";
            format-icons = [
              md-battery_alert.char
              md-battery_10.char
              md-battery_20.char
              md-battery_30.char
              md-battery_40.char
              md-battery_50.char
              md-battery_60.char
              md-battery_70.char
              md-battery_80.char
              md-battery_90.char
              md-battery.char
            ];
          };

          network = {
            format = "{ifname}";
            format-wifi = "{icon} {essid}";
            format-ethernet = "${md-ethernet.char} {ipaddr}/{cidr}";
            format-disconnected = "${md-wifi_strength_off.char} disconnected";
            format-disabled = "${md-airplane.char} disabled";
            tooltip-format = "{ifname} {ipaddr}/{cidr} via {gwaddr}";
            tooltip-format-wifi = "{ifname} {ipaddr}/{cidr} via {gwaddr}\n{signaldBm} dBm ({signalStrength}%)";
            format-icons = [
              md-wifi_strength_outline.char
              md-wifi_strength_1.char
              md-wifi_strength_2.char
              md-wifi_strength_3.char
              md-wifi_strength_4.char
            ];
          };

          backlight = {
            format-icons = with system.icons.set; [
              md-brightness_5.char
              md-brightness_6.char
              md-brightness_6.char
              md-brightness_7.char
            ];
            format = "{icon} {percent}%";
          };

          clock = {
            format = "${md-clock_outline.char} {:%H:%M}";
            format-alt = "${md-calendar_clock.char} {:%A, %B %d, %Y (%R)}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='${foreground}'><b>{}</b></span>";
                days = "<span color='${secondary}'><b>{}</b></span>";
                weeks = "<span color='${foreground}'><b>W{}</b></span>";
                weekdays = "<span color='${foreground}'><b>{}</b></span>";
                today = "<span color='${urgent}'><b><u>{}</u></b></span>";
              };
            };
          };

          wireplumber = {
            format = "{icon} {volume}%";
            format-muted = "${md-volume_mute.char} muted";
            on-click = "${pkgs.rofi}/bin/rofi -show sink_select";
            format-icons = with system.icons.set; [
              md-volume_low.char
              md-volume_medium.char
              md-volume_high.char
            ];
          };
        };
      };
  };
}
