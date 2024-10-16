{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [ "mem_sleep_default=deep" ];
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/86f7b671-9f0d-4008-8e26-cd891f9525ef";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
