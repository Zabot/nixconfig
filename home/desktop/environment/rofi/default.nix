{
  pkgs,
  config,
  ...
}:
{
  programs.rofi = {
    enable = true;

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
        alpha = config.style.opacity;
        alpha-hex = pkgs.lib.toHexString (builtins.floor (255 * alpha));
      in
      with config.colors;
      with config.style;
      {
        "*" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral foreground;
        };

        window = {
          border-color = mkLiteral focus;
          border = mkLiteral "${builtins.toString stroke-width}px";
          padding = mkLiteral "10px";
          background-color = mkLiteral ("${background}${alpha-hex}");
          transparency = "real";
        };

        "element.selected" = {
          background-color = mkLiteral ("${background-hl}${alpha-hex}");
        };
      };

    extraConfig = {
      combi-modi = "window,drun";
      font = "${builtins.head config.fonts.fontconfig.defaultFonts.serif} 12";
    };

    plugins = [
      pkgs.rofi-calc
    ];

    modes = [
      "combi"
      "window"
      "drun"
      "calc"
    ]
    ++ (builtins.attrValues (
      builtins.mapAttrs (name: type: {
        inherit name;
        path = "${./menus}/${name}";
      }) (builtins.readDir ./menus)
    ));
  };
}
