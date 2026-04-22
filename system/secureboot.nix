{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # https://github.com/nix-community/lanzaboote/blob/master/docs/getting-started/prepare-your-system.md
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
