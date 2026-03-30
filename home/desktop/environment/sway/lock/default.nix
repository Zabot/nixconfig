{
  pkgs,
  config,
  options,
  ...
}:
let
  stripHex = name: color: (builtins.substring 1 6 color);
  colors = builtins.mapAttrs stripHex config.colors;
in
{
  options.lock = {
    cmd = pkgs.lib.mkOption { type = pkgs.lib.types.str; };
  };

  config.lock = {
    cmd = "swaylock";
  };

  config.programs.swaylock = {
    enable = true;

    package = pkgs.swaylock.overrideAttrs (finalAttrs: previousAttrs: {
      patches = [ ./polygon.patch ];
    });

    settings = {
      ignore-empty-password = true;
      color  = colors.background;
      image  = ../../../../../resources/lock.png;

      line-uses-inside = true;
      scaling = "center";
      indicator-radius=143;
      indicator-thickness=6;
      indicator-x-position=688;
      indicator-idle-visible = true;

      inside-color="00000000";
      ring-color = colors.background-hl;
      text-color = colors.foreground;

      inside-clear-color= colors.background;
      ring-clear-color = colors.secondary;
      text-clear-color = colors.foreground;

      inside-ver-color= colors.background;
      ring-ver-color = colors.focus;
      text-ver-color = colors.focus;

      inside-wrong-color= colors.background;
      ring-wrong-color = colors.error;
      text-wrong-color = colors.error;

      key-hl-color = colors.secondary;
      bs-hl-color = colors.secondary;
    };
  };
}
