{ config, pkgs, lib, modulesPath, configuration, self, ... }:
let
  # Recursively grab all of the flakes
  flakeOutPaths =
    let
      collector =
        parent:
        map (
          child:
          [ child.outPath ] ++ (if child ? inputs && child.inputs != { } then (collector child) else [ ])
        ) (lib.attrValues parent.inputs);
    in
    lib.unique (lib.flatten (collector self));

  dependencies = [
    configuration.config.system.build.toplevel
    configuration.config.system.build.diskoScript
    configuration.config.system.build.diskoScript.drvPath
    configuration.pkgs.stdenv.drvPath

    # https://github.com/NixOS/nixpkgs/blob/f2fd33a198a58c4f3d53213f01432e4d88474956/nixos/modules/system/activation/top-level.nix#L342
    configuration.pkgs.perlPackages.ConfigIniFiles
    configuration.pkgs.perlPackages.FileSlurp

    (configuration.pkgs.closureInfo { rootPaths = [ ]; }).drvPath
  ] ++ flakeOutPaths;

  closureInfo = pkgs.closureInfo { rootPaths = dependencies; };

in {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.compressImage = false;
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;
  isoImage.storeContents = dependencies;

  environment.etc = {
    "nixconfig".source = self;
    "install-closure".source = "${closureInfo}/store-paths";
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "install-nixos-from-flake" ''
      set -eux
      read -p 'hostname: ' hostname
      read -p 'disk: ' disk
      exec ${pkgs.disko}/bin/disko-install --flake "${self}#$hostname" --disk root "$disk"
    '')
  ];
}
