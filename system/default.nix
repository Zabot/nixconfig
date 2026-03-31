{ config, pkgs, ... }:
{
  # This is the barest of bones config, it only exists to bootstrap
  # an environment. As much config is possible is moved into home
  # manager.
  imports = [
    ./kernel.nix
    ./nix.nix
    ./services.nix
    ./disks.nix
  ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  services.pcscd.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  # This can only be configured globally
  security.pam.services.swaylock = {};
}
