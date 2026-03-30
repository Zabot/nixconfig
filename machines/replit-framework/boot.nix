{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [ "mem_sleep_default=deep" ];
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/9364d479-c35b-4ae9-ac2e-35692892aa77";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
