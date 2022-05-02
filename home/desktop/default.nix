{ config, ... }:
{
  imports = [
    ./i3
    ./alacritty.nix
    ./polybar
    ./autorandr.nix
    ./dunst.nix
  ];

  services.picom = {
    enable = true;
    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" ];

    fade = true;
    fadeDelta = 4;
    fadeSteps = ["0.05" "0.05"];
    vSync = true;
  };
  services.poweralertd.enable = true;
}
