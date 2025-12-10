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
    #style = # pkgs.replaceVars ./waybar.css {
      #(pkgs.substitute {
        #src = ./waybar.css
        #replacements = [
          #"--replace"
          #"background"
          #background
        #]);
      #background = system.colors.background;
    #};
    settings = rec {
      "bar/primary" = {
        position = "bottom";

        modules-left = [ "sway/workspaces" ];
        modules-center = [ ];
        modules-right = [
          "pulseaudio"

          "network"
          "backlight"
          "battery"
          "upower"
          "clock"
        ];
      };
    };
  };
}
