{
  config,
  pkgs,
  lib,
  modulesPath,
  configurations,
  ...
}:
let
  installScript = configuration: with configuration.config.system.build; (pkgs.writeShellScriptBin "install" ''
    set -eux
    ${destroyFormatMount}/bin/disko-destroy-format-mount
    ${nixos-install}/bin/nixos-install \
      --system ${toplevel} \
      --no-root-passwd \
      --no-channel-copy \
      --option substituters \'\' \
      --cores 0
  '');

  postInstall = configuration: (pkgs.writeShellScriptBin "post-install" ''
    set -eux
    ${
      builtins.concatStringsSep
      "\n"
      (
        builtins.map
        (name: "passwd ${name}")
        (
          builtins.attrNames
          (
            lib.filterAttrs
            (name: value: value.isNormalUser)
            configuration.config.users.users
          )
        )
      )
    }
  '');

in {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  isoImage.compressImage = false;
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  environment.systemPackages = [
    pkgs.disko
    (
      pkgs.writeShellScriptBin
      "install-nixos-from-flake"
      ''
        set -eux

        if [ $(id -u) -ne 0 ]; then
          echo "Installer must be run as root"
          exit
        fi

        export PS3="Select system to install: "

        select host in ${builtins.concatStringsSep "\n" (builtins.attrNames configurations)}; do
        case $host in
          ${(
            builtins.concatStringsSep
            "\n"
            (
              builtins.attrValues
              (
                builtins.mapAttrs
                (
                  name: config: let
                    post = postInstall config;
                  in ''
                    ${name})
                      ${installScript config}/bin/install
                      nix copy --to /mnt ${post}
                      ${pkgs.nixos-enter}/bin/nixos-enter --root /mnt -- ${post}/bin/post-install
                      break
                      ;;
                  ''
                )
                configurations
              )
            )
          )}
        esac
        done

        read -p "Installation finished, press enter to reboot..."
        ${pkgs.systemd}/bin/reboot
      ''
    )
  ];
}
