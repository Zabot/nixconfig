{
  config,
  lib,
  pkgs,
  system,
  ...
}:
let
  primary = {
    monitor = "\${env:MONITOR}";

    width = "100%";
    height = 25;
    radius = 0;
    fixed-center = true;
    bottom = true;

    line.size = 3;
    line.color = system.colors.ok;
    background = system.colors.background;
    foreground = system.colors.foreground;

    padding.left = 0;
    padding.right = 2;
    padding.top = 3;

    module.margin.left = 1;
    module.margin.right = 1;

    font = [
      "Overpass:size=13"
      "Inconsolata Nerd Font:size=13"
    ];

    tray.position = "right";
    tray.padding = 2;
    tray.background = system.colors.background-hl;

    wm-restack = "i3";
    scroll-up = "i3.next";
    scroll-down = "i3.prev";

    cursor-click = "pointer";
  };
in
{
  services.polybar.settings = rec {
    "bar/primary" = primary // {
      modules.left = "i3";
      modules.center = "mpd";
      modules.right = "backlight pulseaudio wifi battery date";
    };
    "bar/secondary" = primary // {
      modules.left = "i3";
      modules.center = "mpd";
      modules.right = "date";
    };
  };
}
