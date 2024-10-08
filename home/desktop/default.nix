{ config, pkgs, ... }:
{
  imports = [
    ./i3
    ./alacritty.nix
    ./polybar
    ./wayland
    ./autorandr.nix
    ./dunst.nix
    ./jackrabbit
  ];

  services.picom = {
    enable = true;
    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" ];

    fade = true;
    fadeDelta = 4;
    fadeSteps = [0.05 0.05];
    vSync = true;
  };
  services.poweralertd.enable = true;
  services.redshift = {
    enable = true;
    provider = "manual";
    latitude = 35.0;
    longitude = -100.0;
  };

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-somafm
      mopidy-tunein
    ];
  };
}
