{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Define a set of global options that can be used to configure multiple common
  # modules from one place
  options.global = {
    host = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "A human readable short name for this instance.";
    };

    user = lib.mkOption {
      type = lib.types.submodule {
        options = {
          unixname = lib.mkOption {
            type = lib.types.str;
            default = "nix";
          };
          name = lib.mkOption { type = lib.types.str; };
          email = lib.mkOption { type = lib.types.str; };
        };
      };
    };
  };
}
