{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkbOptions = "caps:escape";
    displayManager.lightdm.background = "/etc/nixos/wallpaper/wallpaper.png";
    desktopManager.xterm.enable = true;
    layout = "us";
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
      };
    };
  };
}
