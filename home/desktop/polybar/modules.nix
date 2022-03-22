with (import ../solarized.nix); {
  "module/date" = {
    type = "internal/date";
    internal = 5;
    date = "%d.%m.%y";
    time = "%H:%M";
    label = "%time% %date%";
    label-underline = colors.yellow;
  };

  "module/battery" = {
    type = "internal/battery";

    # full-at = 99
    # low-at = 5
    battery = "BAT1";
    adapter = "ACAD";
    poll-interval = 5;
  };

  "module/backlight" = {
    type = "internal/backlight";
    card = "intel_backlight";
    enable-scroll = true;

    format = "<label>: <bar>";
    label = "%percentage%%";
    format-underline = colors.yellow;
    bar-width = 7;
    bar-indicator = "|";
    bar-fill = "#";
    bar-empty = "-";
  };

  "module/wifi" = {
    type = "internal/network";
    interface = "wlp170s0";
    label-connected = " %essid%";
    label-connected-underline = colors.green;

    format-disconnected-foreground = semantic.secondary;
    label-disconnected = "Wifi not connected";
    label-disconnected-underline = colors.red;
  };

  "module/i3" = {
    type = "internal/i3";
    format = "<label-state> <label-mode>";
    index-sort = true;
    wrapping-scroll = false;

    # Only show workspaces on the same output as the bar
    pin-workspaces = true;

    label-mode-padding = 2;
    label-mode-foreground = semantic.foreground;
    label-mode-background = colors.yellow;

    label-focused = "%name%";
    label-focused-background = semantic.background-hl;
    label-focused-underline= colors.yellow;
    label-focused-padding = 2;

    label-unfocused = "%name%";
    label-unfocused-background = semantic.background;
    label-unfocused-padding = 2;

    # visible = Active workspace on unfocused monitor
    label-visible = "%name%";
    #label-visible-background = ${self.label-focused-background}
    #label-visible-underline = ${self.label-focused-underline}
    #label-visible-padding = ${self.label-focused-padding}

    #; urgent = Workspace with urgency hint set
    label-urgent = "%name%";
    label-urgent-underline = colors.red;
    label-urgent-background = semantic.background;
    label-urgent-padding = 2;
  };
}
