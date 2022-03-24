{ config, pkgs, ... }:
{
  imports = [
    ./boot.nix
  ];

  networking.wireless.interfaces = [ "wlp170s0" ];
  networking.interfaces.wlp170s0.useDHCP = true;

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  # Slight perf boost and save some SSD write cycles by not updating atime
  # Send TRIM commands to the ssd when blocks are freed
  fileSystems."/".options = ["noatime" "nodiratime" "discard" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
