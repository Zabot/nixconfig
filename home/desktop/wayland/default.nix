{
  config,
  lib,
  pkgs,
  system,
  ...
}:
{
  imports = [ ./waybar.nix ];

  options.desktop.useWayland = lib.options.mkEnableOption "wayland";
}
