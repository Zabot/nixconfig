{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (!config.desktop.useWayland) {
    services.autorandr.enable = true;
    services.xserver = {
      enable = true;
      xkbOptions = "caps:escape";

      desktopManager.xterm.enable = true;
      displayManager.autoLogin = {
        enable = true;
        user = config.global.user.unixname;
      };

      layout = "us";
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          clickMethod = "clickfinger";
          tapping = false;
        };
      };
    };
  };
}
