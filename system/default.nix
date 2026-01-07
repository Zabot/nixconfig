{ config, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./kernel.nix
    ./networking.nix
    ./nix.nix
    ./services.nix
    ./wayland.nix
    ./xserver.nix
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # Inherit the console keymap from the xserver
    useXkbConfig = true;
    packages = [
      pkgs.overpass
      pkgs.nerd-fonts.inconsolata
      pkgs.fantasque-sans-mono
      pkgs.powerline-fonts
    ];
  };

  fonts.packages = [
    pkgs.overpass
    pkgs.nerd-fonts.inconsolata
    pkgs.fantasque-sans-mono
    pkgs.powerline-fonts
  ];

  hardware = {
    rtl-sdr.enable = true;
    pulseaudio.enable = false;
    acpilight.enable = true;
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };
  services.upower.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
