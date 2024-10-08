{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  services.polybar.settings = with system.icons.set; {
    "module/date" = {
      type = "internal/date";
      interval = 5;

      date = "%d.%m.%y";
      date-alt = "%A, %d %B %Y";
      time = "%H:%M";
      time-alt = "%H:%M:%S";

      label = "%time% %date%";
      format = "${system.icons.set.mdi-clock.char}  <label>";
      format-underline = system.colors.ok;
    };

    "module/battery" = {
      type = "internal/battery";
      poll-interval = 5;

      ramp.capacity = [
        system.icons.set.mdi-battery_10.char
        system.icons.set.mdi-battery_30.char
        system.icons.set.mdi-battery_50.char
        system.icons.set.mdi-battery_90.char
        system.icons.set.mdi-battery.char
      ];

      format.charging.text = "${system.icons.set.mdi-battery_charging.char} <label-charging>";
      format.charging.underline = system.colors.ok;

      format.discharging.text = "<ramp-capacity> <label-discharging>";
      format.discharging.underline = system.colors.warn;

      format.low.text = "${system.icons.set.mdi-battery_alert.char} <label-low>";
      format.low.underline = system.colors.urgent;
    } // system.hardware.power;

    "module/wifi" = {
      type = "internal/network";
      interface = system.hardware.defaultWifi;

      label.connected.text = "%essid%";
      format.connected.underline = system.colors.ok;
      format.connected.text = "${system.icons.set.mdi-wifi.char}  <label-connected>";

      label.disconnected.text = "Disconnected";
      format.disconnected.underline = system.colors.urgent;
      format.disconnected.text = "${system.icons.set.mdi-wifi_off.char}  <label-disconnected>";
      format.disconnected.foreground = system.colors.secondary;
    };

    "module/pulseaudio" = {
      type = "internal/pulseaudio";
      use-ui-max = false;
      interval = 5;

      format.volume.text = "<ramp-volume> <label-volume>";
      format.volume.underline = system.colors.ok;

      label.muted.text = "${mdi-volume_mute.char}  Muted";
      format.muted.foreground = system.colors.secondary;
      format.muted.underline = system.colors.urgent;

      ramp-volume = [
        mdi-volume_low.char
        mdi-volume_medium.char
        mdi-volume_high.char
      ];
      click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
    };

    "module/backlight" = {
      type = "internal/backlight";
      card = "intel_backlight";
      enable-scroll = true;
      ramp = [
        mdi-brightness_5.char
        mdi-brightness_6.char
        mdi-brightness_6.char
        mdi-brightness_7.char
      ];

      label = "%percentage%%";
      format.text = "<ramp>  <label>";
      format.underline = system.colors.ok;
    };

    "module/i3" = {
      type = "internal/i3";
      format = "<label-state> <label-mode>";
      index-sort = true;
      wrapping-scroll = false;

      # Only show workspaces on the same output as the bar
      pin-workspaces = true;

      label.mode.padding = 2;
      label.mode.foreground = system.colors.foreground;
      label.mode.background = system.colors.ok;

      label.focused.text = "%name% %icon%";
      label.focused.background = system.colors.background-hl;
      label.focused.underline = system.colors.ok;
      label.focused.padding = 2;

      label.unfocused.text = "%name% %icon%";
      label.unfocused.background = system.colors.background;
      label.unfocused.padding = 2;

      # visible = Active workspace on unfocused monitor
      label.visible.text = "%name% %icon%";
      label.visible.underline = system.colors.ok;
      label.visible.background = system.colors.background-hl;
      label.visible.padding = 2;

      #; urgent = Workspace with urgency hint set
      label.urgent.text = "%name%";
      label.urgent.underline = system.colors.urgent;
      label.urgent.background = system.colors.background;
      label.urgent.padding = 2;
    };

    "module/mpd" = with system.icons.set; {
      type = "internal/mpd";

      host = "127.0.0.1";
      port = "6600";

      interval = 2;
      format-online = "<toggle>  <label-song>";
      format-online-underline = system.colors.ok;
      label-song = "%title%";

      icon-play = mdi-music_off.char;
      icon-pause = mdi-music.char;
    };
  };
}
