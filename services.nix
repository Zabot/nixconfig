{ config, pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.autorandr.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;
  programs.steam.enable = true;

  programs.adb.enable = true;

}
