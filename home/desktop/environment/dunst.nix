{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "keyboard";
        font = "${builtins.head config.fonts.fontconfig.defaultFonts.serif} 12";
        padding = 10;
        shrink = true;
        word_wrap = true;
        horizontal_padding = 10;

        frame_width = config.style.stroke-width;
        separator_color = "frame";
        timeout = 10;

        progress_bar_height = 8;
        progress_bar_frame_width = 0;
        highlight = config.colors.secondary;
        max_icon_size = 64;
      };

      urgency_normal = {
        background = config.colors.background-hl;
        foreground = config.colors.foreground;
        frame_color = config.colors.notice;
      };

      urgency_low = {
        background = config.colors.background-hl;
        foreground = config.colors.foreground;
        frame_color = config.colors.secondary;
      };

      urgency_critical = {
        background = config.colors.background-hl;
        foreground = config.colors.foreground;
        frame_color = config.colors.urgent;
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
