{ config, lib, pkgs, ... }:
{
  options.desktop.useWayland = lib.options.mkEnableOption "wayland";

  config = lib.mkIf config.desktop.useWayland {
    services.getty.autologinUser = config.global.user.unixname;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.sway = {
      enable = true;

      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=sway
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export MOZ_ENABLE_WAYLAND=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        export NIXOS_OZONE_WL=1
      '';
    };
  };
}
