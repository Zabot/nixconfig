{ config, pkgs, ... }:
let
  secrets = import ./secrets.nix;
in {
  networking.wireless.enable = true;
  networking.wireless.networks = secrets.wifi;

  networking.useDHCP = false;
  security.pki.certificateFiles = [
    /home/zach/Documents/homelab/ssl_ca/crt/ca.crt
  ];
}
