{ config, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./services.nix
  ];

  system.stateVersion = "21.11";
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # Inherit the console keymap from the xserver
    useXkbConfig = true;
  };

  # Allow nix without sudo
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
    acpilight.enable = true;
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };
  services.upower.enable = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = [
    pkgs.intel-compute-runtime
  ];
}
