{
  config,
  lib,
  pkgs,
  ...
}:
let
  email = import ../secrets/email.nix;
in
{
  # We enable the email configs, but that doesn't actually enable the services
  programs = {
    neomutt.enable = true;
  };

  services = {
    imapnotify.enable = true;
  };

  accounts.email = {
    maildirBasePath = "mail";
    accounts = {
      fastmail = {
        address = "zach@zabot.dev";
        primary = true;
        realName = "Zach Anderson";

        userName = "zabot@fastmail.com";
        passwordCommand = [
          "${pkgs.coreutils}/bin/cat"
          config.age.secrets.fastmail-pass.path
        ];

        # neomutt directly access the imap server. It may be worth setting up maildir
        # and something to sync instead.
        neomutt = {
          enable = true;
          mailboxType = "imap";
        };

        imapnotify = {
          enable = true;
          boxes = [ ];
          onNotifyPost = "${pkgs.dunst}/bin/dunstify 'New mail arrived'";
        };

        imap = {
          host = "imap.fastmail.com";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.fastmail.com";
          port = 465;
          tls.enable = true;
          tls.useStartTls = false;
        };
      };
    };
  };
}
