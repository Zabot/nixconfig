{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.jackrabbit;
  tomlFormat = pkgs.formats.toml { };

  jackrabbitConfig = {
    interface = cfg.interface;
    default = cfg.default;
    bookmarks = cfg.bookmarks;
  };

  configFile = tomlFormat.generate "jackrabbit.toml" jackrabbitConfig;
in
{
  options = {
    services.jackrabbit = {
      enable = lib.mkEnableOption "Jackrabbit search bookmarks";

      interface = lib.mkOption {
        type = lib.types.str;
        description = "The interface to bind to";
        default = "127.0.0.1:8080";
      };

      default = lib.mkOption {
        type = lib.types.str;
        description = "The default route if no prefix is matched";
        default = "https://duckduckgo.com/?q={}";
      };

      bookmarks = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        description = "The list of keywords and bookmarks";
        default = { };
        example = lib.literalExpression ''
          {
            g = "https://duckduckgo.com/?q={}";
            nix = "https://search.nixos.org/packages?query={}";
            go = "https://pkg.go.dev/search?q={}";
            rust = "https://docs.rs/releases/search?query={}";
            std = "https://www.cplusplus.com/search.do?q={}";
          }
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable rec {
    home.packages = [ pkgs.jackrabbit ];
    xdg.configFile."jackrabbit/config.toml".source = configFile;

    systemd.user.services.jackrabbit = {
      Unit = {
        Description = "Jackrabbit search bookmarks";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.jackrabbit}/bin/jackrabbit --config ${config.xdg.configHome}/jackrabbit/config.toml";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
