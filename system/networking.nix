{ config, pkgs, ... }:
let
  wifi = import ../secrets/wifi.nix;
in {
  networking.hostName = "${config.global.user.unixname}-${config.global.host}";
  networking.wireless.enable = true;
  networking.wireless.networks = wifi;

  networking.useDHCP = false;
  security.pki.certificateFiles = [
    ../secrets/ca.crt
  ];
}
