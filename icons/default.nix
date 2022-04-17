{ lib
, config
, pkgs
, ... }:
let
  icons = (pkgs.callPackage ./icons.nix) {};
in
{
  config.icons = {
    set = import icons;
    svg = color: icon: (pkgs.substitute {
      src = icon.icon;
      replacements = [ "--replace" "currentColor" color ];
    });
  };

  options.icons = {
    set = lib.mkOption {
      type = lib.types.attrs;
    };
    svg = lib.mkOption {
      type = lib.types.functionTo (lib.types.functionTo lib.types.path);
    };
  };
}
