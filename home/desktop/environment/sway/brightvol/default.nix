{
  config,
  lib,
  pkgs,
  system,
  ...
}:
let
  svg = system.icons.svg config.colors.foreground;

  volume = pkgs.wrap {
    src = ./volume.sh;
    env = with system.icons.set; {
      ICON_MUTED = svg md-volume_mute;
      ICON_LOW = svg md-volume_low;
      ICON_MID = svg md-volume_medium;
      ICON_HIGH = svg md-volume_high;
      SOUND_CHANGE_VOLUME = ./boop.wav;
    };
  };

  brightness = pkgs.wrap {
    src = ./brightness.sh;
    env = with system.icons.set; {
      ICON_LOW = svg md-brightness_5;
      ICON_MID = svg md-brightness_6;
      ICON_HIGH = svg md-brightness_7;
    };
  };
in
{
  config.volume = {
    up = "${volume} up";
    down = "${volume} down";
    mute = "${volume} mute";
  };

  config.brightness = {
    up = "${brightness} up";
    down = "${brightness} down";
  };

  options.volume = {
    up = pkgs.lib.mkOption { type = pkgs.lib.types.str; };
    down = pkgs.lib.mkOption { type = pkgs.lib.types.str; };
    mute = pkgs.lib.mkOption { type = pkgs.lib.types.str; };
  };

  options.brightness = {
    up = pkgs.lib.mkOption { type = pkgs.lib.types.str; };
    down = pkgs.lib.mkOption { type = pkgs.lib.types.str; };
  };
}
