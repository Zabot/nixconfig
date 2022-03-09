{ config, pkgs, ... }:
let
  wifi = import ../secrets/wifi.nix;
in {
  networking.wireless.enable = true;
  networking.wireless.networks = wifi;

  networking.useDHCP = false;
  security.pki.certificateFiles = [
    ../secrets/ca.crt
  ];
}
