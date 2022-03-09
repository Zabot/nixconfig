{ config, lib, pkgs, ... }:
with (import ./solarized.nix); {

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
        background = semantic.background-hl;
        foreground = semantic.foreground;
				frame_color = colors.yellow;
			};

			urgency_low = {
        background = semantic.background-hl;
        foreground = semantic.foreground;
				frame_color = semantic.secondary;
			};

			urgency_critical = {
        background = semantic.background-hl;
        foreground = semantic.foreground;
				frame_color = colors.red;
			};
    };
  };

}
