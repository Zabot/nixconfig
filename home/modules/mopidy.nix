{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let
  cfg = config.services.mopidy;

  mopidyConf = writeText "mopidy.conf" cfg.configuration;

  mopidyEnv = buildEnv {
    name = "mopidy-with-extensions-${mopidy.version}";
    paths = closePropagation cfg.extensionPackages;
    pathsToLink = [ "/${mopidyPackages.python.sitePackages}" ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      makeWrapper ${mopidy}/bin/mopidy $out/bin/mopidy \
        --prefix PYTHONPATH : $out/${mopidyPackages.python.sitePackages}
    '';
  };
in {

  options = {

    services.mopidy = {

      enable = mkEnableOption "Mopidy, a music player daemon";

      dataDir = mkOption {
        default = "/var/lib/mopidy";
        type = types.str;
        description = ''
          The directory where Mopidy stores its state.
        '';
      };

      extensionPackages = mkOption {
        default = [];
        type = types.listOf types.package;
        example = literalExpression "[ pkgs.mopidy-spotify ]";
        description = ''
          Mopidy extensions that should be loaded by the service.
        '';
      };

      configuration = mkOption {
        default = "";
        type = types.lines;
        description = ''
          The configuration that Mopidy should use.
        '';
      };

      extraConfigFiles = mkOption {
        default = [];
        type = types.listOf types.str;
        description = ''
          Extra config file read by Mopidy when the service starts.
          Later files in the list overrides earlier configuration.
        '';
      };

    };

  };

  ###### implementation

  config = mkIf cfg.enable {

    #systemd.tmpfiles.rules = [
      #"d '${cfg.dataDir}' - mopidy mopidy - -"
    #];

    systemd.user.services.mopidy = {
      Unit = {
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = "${mopidyEnv}/bin/mopidy --config ${concatStringsSep ":" ([mopidyConf] ++ cfg.extraConfigFiles)}";
      };
    };

    systemd.user.services.mopidy-scan = {
      #description = "mopidy local files scanner";
      Service = {
        ExecStart = "${mopidyEnv}/bin/mopidy --config ${concatStringsSep ":" ([mopidyConf] ++ cfg.extraConfigFiles)} local scan";
        Type = "oneshot";
      };
    };
  };

}
