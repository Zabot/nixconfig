{ config, pkgs, ... }:
{
  programs.adb.enable = true;
  programs.vim.package = pkgs.vim;
  programs.vim.defaultEditor = true;

  virtualisation.docker.enable = true;

  services.printing.enable = true;
  services.udev.packages = with pkgs; [ yubikey-personalization ];
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';
  services.logind.lidSwitch = "hibernate";

  security.polkit.enable = true;
}
