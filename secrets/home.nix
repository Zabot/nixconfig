{
  pkgs,
  inputs,
  lib,
  withSecrets,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age =
    let
      ageCommon = (import ./common.nix) { inherit pkgs; };
    in
    {
      package = ageCommon.package;
      identityPaths = ageCommon.identityPaths;
      secrets = lib.mkIf withSecrets inputs.secrets.secrets.user;
    };
}
