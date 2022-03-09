{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
in
{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./home.nix
    ./services.nix
    ./machines/detect.nix
    ./xserver.nix
  ];

  fileSystems."/".options = ["noatime" "nodiratime" "discard" ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true;
  };

  nix.trustedUsers = [
    "root"
    "@wheel"
  ];

  fonts.fonts = [
    pkgs.overpass
    pkgs.inconsolata-nerdfont
    pkgs.fantasque-sans-mono
    pkgs.powerline-fonts
  ];

  sound.enable = true;
  hardware = {
    rtl-sdr.enable = true;
    pulseaudio.enable = true;
    bluetooth.enable = true;
    acpilight.enable = true;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "21.05";
}
