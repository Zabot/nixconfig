{ config, lib, pkgs, system, ... }:
{
	programs.autorandr = {
    hooks = {
      postswitch = {
        "restart-polybar" = "systemctl --user restart polybar";
        "change-background" = "systemctl --user start random-background";
      };
    };

    enable = true;
    profiles = builtins.mapAttrs (_: c: (pkgs.lib-autorandr.config c)) system.hardware.displays;
  };
}
