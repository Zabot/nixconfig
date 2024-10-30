{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./displays.nix
  ];

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  # Slight perf boost and save some SSD write cycles by not updating atime
  # Send TRIM commands to the ssd when blocks are freed
  fileSystems."/".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  hardware.defaultWifi = "wlp170s0";
  hardware.power = {
    battery = "BAT1";
    adapter = "ACAD";
  };
}
