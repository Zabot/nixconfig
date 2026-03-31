{ config, pkgs, lib, modulesPath, configuration, self, ... }:
let
  system = configuration.config.system.build.toplevel;
in {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.compressImage = false;
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;
  #isoImage.storeContents = dependencies;

  environment.etc = {
    "nixconfig".source = self.outPath;
    "system".source = system;
  };

  environment.systemPackages = [
    pkgs.disko

    (pkgs.runCommand "disko-scripts" {} ''
      mkdir $out
      cp ${configuration.config.system.build.diskoScript} $out
      cp ${configuration.config.system.build.formatScript} $out
      cp ${configuration.config.system.build.mountScript} $out
      cp ${configuration.config.system.build.destroyScript} $out
    '')

    configuration.config.system.build.destroyFormatMount
    configuration.config.system.build.formatMount

    (pkgs.writeShellScriptBin "install-nixos-from-flake" ''
      set -eux
      exec ${config.system.build.nixos-install}/bin/nixos-install \
        --system ${system} \
        --cores 0
    '')
  ];
}
