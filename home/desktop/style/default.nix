{ lib, ... }:
{
  imports = [
    ./fonts.nix
  ];

  # Global colorscheme
  options.colors =
    with lib;
    with types;
    lib.mkOption {
      type = lib.types.submodule {
        options = {
          # Content colors
          background = mkOption { type = str; };
          background-hl = mkOption { type = str; };
          secondary = mkOption { type = str; };
          foreground = mkOption { type = str; };
          emph = mkOption { type = str; };

          # Notification colors
          urgent = mkOption { type = str; };
          notice = mkOption { type = str; };

          # Status colors
          error = mkOption { type = str; };
          warn = mkOption { type = str; };
          ok = mkOption { type = str; };

          # Interface colors
          focus = mkOption { type = str; };
          focus-accent = mkOption { type = str; };

          # Terminal mapping
          termcolors = mkOption { type = attrs; };
        };
      };
    };

  options.style =
    with lib;
    with types;
    lib.mkOption {
      type = submodule {
        options = {
          stroke-width = mkOption { type = int; };
        };
      };
    };
}
