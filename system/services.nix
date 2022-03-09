{ config, pkgs, ... }:
{
  programs.adb.enable = true;
  programs.vim.package = pkgs.vim;
  programs.vim.defaultEditor = true;

  virtualisation.docker.enable = true;

  services.autorandr.enable = true;
  services.printing.enable = true;
  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  services.xserver = {
    enable = true;
    xkbOptions = "caps:escape";

    desktopManager.xterm.enable = true;
    displayManager.autoLogin = {
      enable = true;
      user = "zach";
    };

    layout = "us";
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
      };
    };
  };
}
