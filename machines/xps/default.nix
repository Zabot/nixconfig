{ config, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./displays.nix
    ./hardware-configuration.nix
  ];

  networking.wireless.interfaces = [ "wlp0s20f3" ];
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Slight perf boost and save some SSD write cycles by not updating atime
  # Send TRIM commands to the ssd when blocks are freed
  fileSystems."/".options = ["noatime" "nodiratime" "discard" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable fingerprint auth
  hardware.defaultWifi = "wlp0s20f3";
  hardware.power = {
    battery = "BAT0";
    adapter = "AC";
  };

  desktop.useWayland = false;
}
