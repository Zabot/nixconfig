{ lib, ... }:
{
  # Global colorscheme
  options.colors = with lib; with types; lib.mkOption {
    type = lib.types.submodule {
      options = {
        # Content colors
        background = mkOption { type = str; };
        background-hl = mkOption { type = str; };
        secondary = mkOption {
          type = str;
          description = "Secondary foreground content";
        };
        foreground = mkOption {
          type = str;
          description = "Primary foreground content";
        };
        emph = mkOption {
          type = str;
          description = "Emphasised foreground content";
        };

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
}
