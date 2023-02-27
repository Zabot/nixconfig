{ config, pkgs, ... }:
{
  # Allow nix without sudo
  nix.trustedUsers = [
    "root"
    "@wheel"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
