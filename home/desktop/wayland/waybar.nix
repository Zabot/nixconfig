{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  programs.waybar = lib.mkIf config.desktop.useWayland {
    enable = true;
    systemd = {
      enable = true;
    };

    settings = rec {
      "bar/primary" = {
        position = "bottom";

        modules-left = [ "sway/workspaces" ];
        modules-center = [ "mpd" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "clock"
        ];
      };
    };
  };
}
