{ config, pkgs, ... }:
{
  networking.hostName = "${config.global.user.unixname}-${config.global.host}";
  networking.networkmanager.enable = true;
}
