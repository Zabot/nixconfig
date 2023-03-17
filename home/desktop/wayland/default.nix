{ config, lib, pkgs, system, ... }:
{
  options.desktop.useWayland = lib.options.mkEnableOption "wayland";

  config = {
    programs.waybar = lib.mkIf config.desktop.useWayland {
      enable = true;
      systemd = {
        enable = true;
      };

      settings = rec {
        "bar/primary" = {
          modules-left = [ "sway/workspaces" ];
          modules-center = [ "mpd" ];
          modules-right = [ "pulseaudio" "network" "battery" "clock"];
        };
      };
    };
  };
}

