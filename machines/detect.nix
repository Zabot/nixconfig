{ config, pkgs, ... }:
{
  imports = [
    # TODO Determine machine by matching disk names defined in hardware-configuration
    ./framework.nix
  ];
}
