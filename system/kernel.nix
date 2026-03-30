{ config, pkgs, ... }:
{
  boot.loader = {
    timeout = 2;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };

  console = {
    earlySetup = true;
    keyMap = "us";
    # Console fonts must be fixed width. We can't have exactly what we want, but we can at least get
    # something a little nicer, and bigger for hiDPI display.
    font = "ter-132n";
    packages = [
      pkgs.terminus_font
    ];
  };
}
