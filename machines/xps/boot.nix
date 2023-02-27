{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [ "mem_sleep_default=deep" ];
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/f3024c0b-b286-43c9-8cb3-4f8b00bd68e7";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
