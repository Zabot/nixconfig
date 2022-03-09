{ config, pkgs, ... }:
{
  networking.hostName = "zach-framework";
  networking.wireless.interfaces = [ "wlp170s0" ];
  networking.interfaces.wlp170s0.useDHCP = true;
}
