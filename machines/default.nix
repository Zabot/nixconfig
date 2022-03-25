{pkgs, config, ...} @ args:
let
  # Conditional import is a function that takes a condition and returns a function
  # that converts a module path to a function that imports that module while
  # applying the conditional import to all of its imports.
  conditional_import = condition: (
    module: let
      realized = (import module) args;
      config = builtins.removeAttrs realized [ "imports" ];
    in args: {
      # Map all of the imports to conditional imports
      imports = builtins.map
        (conditional_import condition)
        (if realized ? imports then realized.imports else []);
      # Move all of the top level configs into a config array and combine with
      # config values
      config = args.lib.mkIf
        (condition)
        (config // (if config?config then config.config else {}));
    }
  );

  # Given a module that points to a machine directory, conditionally include it
  # if the host config matches the directory.
  wrap = module: let
    name = builtins.baseNameOf module;
    enabled = args.config.global.host == name;
  in (conditional_import enabled) module;

  # List of nix modules containing machine specific configuration. This list
  # is matched against global.host to determine which module to include.
  machines = [
    ./framework
  ];

in
{
  # We can't conditionally import modules, so instead we import all of the
  # modules and conditionally define their config values to accomplish a similar
  # effect.
  imports = (builtins.map wrap machines) ++ [ ./hardware.nix ];
}
