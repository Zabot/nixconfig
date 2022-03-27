{ config, ... }:
{
  imports = [
    ./i3
    ./alacritty.nix
    ./polybar
    ./autorandr.nix
    ./dunst.nix
  ];
}
