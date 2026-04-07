{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.tiny = {
    enable = true;
    settings = {
      servers = [
        {
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
          realname = "Zabot";
          nicks = [ "zabot" ];
          join = [
            "##rust"
            "#vim"
            "#sway"
            "#fsf"
            "#osdev"
            "##chat"
            "#nixos"
            "#homeassistant"
          ];
          pass = {
            # Need to use sh to substitute XDG_RUNTIME_DIR
            command = "${pkgs.bash}/bin/sh -c '${pkgs.coreutils}/bin/cat ${config.age.secrets.irc-libera-pass.path}'";
          };
        }
      ];
      defaults = {
        realname = "Zabot";
        nicks = [ "zabot" ];
        join = [];
        tls = true;
      };
    };
  };
}
