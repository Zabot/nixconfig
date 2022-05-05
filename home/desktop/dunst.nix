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

        progress_bar_height = 5;
        progress_bar_frame_width = 0;
        highlight = system.colors.secondary;
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

      volume = {
        appname = "volume";
        hide_text = true;
      };
    };
  };
}
