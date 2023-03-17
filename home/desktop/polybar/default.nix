{ config, lib, pkgs, system, ... }:
{

  imports = [
    ./modules.nix
    ./bars.nix
  ];

  # Make sure that the i3 socket is open before trying to start polybar
  systemd.user.services.polybar = lib.mkIf (!config.desktop.useWayland) {
    Unit.After = [ "i3-session.target" ];
    Install.WantedBy = lib.mkForce [ "i3-session.target" ];
  };

  # Restart polybar when the config changes
  xdg.configFile."polybar/config.ini" = lib.mkIf (!config.desktop.useWayland) {
    onChange = "systemctl --user restart polybar";
  };

  services.polybar = lib.mkIf (!config.desktop.useWayland) {
    enable = true;
    script = ''
      echo "Starting polybar on all displays..."
      for m in $(polybar -m | ${pkgs.coreutils}/bin/tr ' ' '/')
      do
        bar=$(echo $m | ${pkgs.gnugrep}/bin/grep primary > /dev/null && echo primary || echo secondary)
        export MONITOR=$(echo $m | ${pkgs.gnused}/bin/sed -e 's/:.*$//g')
        echo $bar on $MONITOR
        polybar $bar &
      done
      '';
    package = pkgs.polybarFull;
    settings = {
      settings = {
        screenchange-reload = true;
      };
    };
  };
}

