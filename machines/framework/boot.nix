{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "mem_sleep_default=deep" ];

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/ebc25cc9-5fc6-4c84-963e-9032b9681956";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
