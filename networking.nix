{ config, pkgs, ... }:
let
  wifi = import ./secrets/wifi.nix;
in {
  networking.wireless.enable = true;
  networking.wireless.networks = wifi;

  networking.useDHCP = false;
  security.pki.certificateFiles = [
    /home/zach/Documents/homelab/ssl_ca/crt/ca.crt
  ];
}
