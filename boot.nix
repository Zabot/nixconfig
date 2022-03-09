{ config, lib, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/ebc25cc9-5fc6-4c84-963e-9032b9681956";
      preLVM = true;
      allowDiscards = true;
    };
  };
}
