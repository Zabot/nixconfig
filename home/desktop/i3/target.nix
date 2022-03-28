{ config, pkgs, lib, ... }:
{
  # Nix doesn't start i3 as a systemd unit, its run by the display manager as
  # a child. Additionally, the hm-graphical-session target is started before
  # i3 is launched. That means we can't add dependencies on i3 for services that
  # talk to it (like polybar). Since there is no way to determine when i3 is running,
  # we add a new systemd target that will be marked as started by i3 when it runs
  # its startup commands.
  systemd.user.targets.i3-session = {
    Unit = {
      Description = "i3 X session";
      BindsTo = [ "hm-graphical-session.target" ];
      Requisite = [ "hm-graphical-session.target" ];
    };
  };

  # Add a command to mark the target as started when i3 starts up
  xsession.windowManager.i3.config.startup = [
    {
      command = "${pkgs.systemd}/bin/systemctl --user start i3-session.target";
      notification = false;
    }
  ];
}
