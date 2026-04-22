{
  ...
}:
{
  hardware.enableRedistributableFirmware = true;
  fileSystems."/".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.fwupd.enable = true;

  hardware.defaultWifi = "wlp1s0";
  hardware.power = {
    battery = "BAT1";
    adapter = "AC";
  };

  disko.enable = true;
  disko.rootDisk = "/dev/nvme0n1";

  boot = {
    kernelParams = [
      "mem_sleep_default=deep"
      "amd_pstate=passive"
    ];

    kernelModules = [ "kvm-amd" ];
    initrd = {
      kernelModules = [ "dm-snapshot" ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "sd_mod"
      ];
    };
  };
}
