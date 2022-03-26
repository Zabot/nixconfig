{ config, lib, pkgs, system, ... }:
{

  services.dunst = {
    enable = true;

		settings = {
			global = {
				follow = "keyboard";
				geometry = "500x5-10+10";
        font = "Overpass 12";
				padding = 10;
        shrink = true;
        word_wrap = true;
				horizontal_padding = 10;

				frame_width = 2;
				separator_color = "frame";
        timeout = 10;
			};

      urgency_normal = {
        background = system.colors.background-hl;
        foreground = system.colors.foreground;
        frame_color = system.colors.notice;
      };

      urgency_low = {
        background = system.colors.background-hl;
        foreground = system.colors.foreground;
        frame_color = system.colors.secondary;
      };

      urgency_critical = {
        background = system.colors.background-hl;
        foreground = system.colors.foreground;
        frame_color = system.colors.urgent;
      };
    };
  };

}
