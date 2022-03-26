{ config, lib, pkgs, system, ... }:
{
  services.polybar.config = {
		"bar/top" = {
			width = "100%";
			height = 20;
			radius = 0;
      fixed-center = true;
      bottom = true;

      background = system.colors.background;
      foreground = system.colors.foreground;

      line-size = 3;
      line-color = system.colors.ok;

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
      modules-right = [ "battery" "backlight" "wifi" "date" ];
      #modules-center = [ "date" ];

      tray-position = "right";
      tray-padding = 2;
      tray-background = system.colors.background-hl;

      wm-restack = "i3";

      scroll-up = "i3.next";
      scroll-down = "i3.prev";

      cursor-click = "pointer";
    };
	} // import ./modules.nix {system = system;};
}

