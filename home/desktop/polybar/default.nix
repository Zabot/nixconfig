{ config, lib, pkgs, system, ... }:
{

  imports = [
    ./modules.nix
    ./bars.nix
  ];

  # Make sure that the i3 socket is open before trying to start polybar
  systemd.user.services.polybar = {
    Unit.After = [ "i3-session.target" ];
    Install.WantedBy = lib.mkForce [ "i3-session.target" ];
  };

  # Restart polybar when the config changes
  xdg.configFile."polybar/config" = {
    onChange = "systemctl --user restart polybar";
  };

  services.polybar.settings = {
    settings = {
      screenchange-reload = true;
    };
  };
}

