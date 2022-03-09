{ config, lib, pkgs, ... }:
with (import ./solarized.nix); {
  services.polybar.config = {
		"bar/top" = {
			#monitor = "\${env:MONITOR:eDP1}";
			width = "100%";
			height = 20;
			radius = 0;
      fixed-center = true;
      bottom = true;

      background = colors.base03;
      foreground = colors.base0;

      line-size = 3;
      line-color = colors.red;

      padding-left = 0;
      padding-right = 2;

      module-margin-left = 1;
      module-margin-right = 1;

      font = [
        "Overpass:size=12"
        #"Inconsolata-g for Powerline:size=12"
      ];

      modules-left = [ "i3" ];
      #modules-center = mpd
      #modules-right = xbacklight alsa temperature cpu battery wifi date
      modules-right = [ "xbacklight" "wifi" "date" ];
      #modules-center = [ "date" ];

      tray-position = "right";
      tray-padding = 2;
      tray-background = colors.green;

      wm-restack = "i3";

      scroll-up = "i3.next";
      scroll-down = "i3.prev";

      cursor-click = "pointer";
    };

		"module/date" = {
			type = "internal/date";
			internal = 5;
			date = "%d.%m.%y";
			time = "%H:%M";
			label = "%time%  %date%";
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

    "module/xbacklight" = {
      type = "internal/xbacklight";
      output = "eDP-1";
      enable-scroll = true;
      format = "BL: <bar>";
      bar-width = 7;
      bar-indicator = "|";
      bar-fill = "─";
      bar-empty = "─";
    };

    "module/wifi" = {
      type = "internal/network";
      interface = "wlp0s20f3";
      label-connected = " %essid%";
      label-connected-underline = colors.green;

      format-disconnected-foreground = semantic.secondary;
      label-disconnected = "Wifi not connected";
      label-disconnected-underline = colors.red;
    };
	};
}

