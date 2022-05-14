{ config, lib, pkgs, system, ... }:
{

  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "keyboard";
        font = "Overpass 12";
        padding = 10;
        shrink = true;
        word_wrap = true;
        horizontal_padding = 10;

        frame_width = 2;
        separator_color = "frame";
        timeout = 10;

        progress_bar_height = 8;
        progress_bar_frame_width = 0;
        highlight = system.colors.secondary;
        max_icon_size = 64;
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
        shrink = true;
        width = 120;
        hide_text = true;
        icon_position = "top";
      };

      brightness = {
        shrink = true;
        appname = "brightness";
        width = 120;
        hide_text = true;
        icon_position = "top";
      };
    };
  };
}
