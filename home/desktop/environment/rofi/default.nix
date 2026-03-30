{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      with config.colors;
      with config.style;
    {
      "*" = {
        background-color = mkLiteral background;
        text-color = mkLiteral foreground;
      };

      window = {
        border-color = mkLiteral focus;
        border =  mkLiteral "${builtins.toString stroke-width}px";
        padding = mkLiteral "10px";
      };

      element-text = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element.selected" = {
        background-color = mkLiteral background-hl;
        text-color = mkLiteral foreground;
      };

      "element.normal.normal" =  {
         background-color = mkLiteral background;
        text-color = mkLiteral secondary;
      };

      "element.alternate.normal" = {
        text-color = mkLiteral secondary;
      };

      "#textbox-prompt-colon" = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral foreground;
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
    ] ++ (builtins.attrValues (
      builtins.mapAttrs (name: type: {
        inherit name;
        path = "${./menus}/${name}";
      }) (builtins.readDir ./menus)
    ));
  };
}
