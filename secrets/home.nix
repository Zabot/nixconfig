{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age = let
    ageCommon = (import ./common.nix) { inherit pkgs; };
  in {
    package = ageCommon.package;
    identityPaths = ageCommon.identityPaths;

    secrets = {
      fastmail-pass = {file = ./secrets/fastmail.age;};
    };
  };
}
