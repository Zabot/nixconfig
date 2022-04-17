{system, ...}:
{
  "module/date" = {
    type = "internal/date";
    internal = 5;
    date = "%d.%m.%y";
    time = "%H:%M";
    label = "${system.icons.set.mdi-clock.char} %time% %date%";
    label-underline = system.colors.ok;
  };

  "module/battery" = {
    type = "internal/battery";

    # full-at = 99
    # low-at = 5
    poll-interval = 5;
  } // system.hardware.power;

  "module/backlight" = {
    type = "internal/backlight";
    card = "intel_backlight";
    enable-scroll = true;

    format = "<label>: <bar>";
    label = "%percentage%%";
    format-underline = system.colors.ok;
    bar-width = 7;
    bar-indicator = "|";
    bar-fill = "#";
    bar-empty = "-";
  };

  "module/wifi" = {
    type = "internal/network";
    interface = system.hardware.defaultWifi;
    label-connected = "${system.icons.set.mdi-wifi.char} %essid%";
    label-connected-underline = system.colors.ok;

    format-disconnected-foreground = system.colors.secondary;
    label-disconnected = "Wifi not connected";
    label-disconnected-underline = system.colors.urgent;
  };

  "module/i3" = {
    type = "internal/i3";
    format = "<label-state> <label-mode>";
    index-sort = true;
    wrapping-scroll = false;

    # Only show workspaces on the same output as the bar
    pin-workspaces = true;

    label-mode-padding = 2;
    label-mode-foreground = system.colors.foreground;
    label-mode-background = system.colors.ok;

    label-focused = "%name%";
    label-focused-background = system.colors.background-hl;
    label-focused-underline= system.colors.ok;
    label-focused-padding = 2;

    label-unfocused = "%name%";
    label-unfocused-background = system.colors.background;
    label-unfocused-padding = 2;

    # visible = Active workspace on unfocused monitor
    label-visible = "%name%";
    #label-visible-background = ${self.label-focused-background}
    #label-visible-underline = ${self.label-focused-underline}
    #label-visible-padding = ${self.label-focused-padding}

    #; urgent = Workspace with urgency hint set
    label-urgent = "%name%";
    label-urgent-underline = system.colors.urgent;
    label-urgent-background = system.colors.background;
    label-urgent-padding = 2;
  };
}
