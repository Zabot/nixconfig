{
  config,
  lib,
  inputs,
  ...
}:
{
  nix = {
    settings = {
      # Allow nix without sudo
      trusted-users = [
        "root"
        "@wheel"
      ];
      # Flakes all the way
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    # Populate the system wide flake registry with the inputs to this flake. There should be no
    # references to nix channels at all, everything is flakes now
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # We're all in on flakes, to maintain backwards compatibility set the nix path to reference
    # the system flake registry
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    channel.enable = false;
  };
}
