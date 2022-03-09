{ config, lib, pkgs, ... }:

{
  accounts.email.accounts = {
    Replit = {
      address = "zabot@repl.it";
      aliases = [ "zabot@replit.com" ];
      primary = true;
      realName = "Zach Anderson";

      userName = "zabot@repl.it";
      passwordCommand = "echo REDACTED";

      neomutt.enable = true;
      imapnotify.enable = true;
      imapnotify.boxes = [ "Inbox" ];
      imapnotify.onNotifyPost = "${pkgs.libnotify}/bin/notify-send 'New mail arrived'";

      #gpg = {
        #encryptByDefault = true;
        #signByDefault = true;
      #};

      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
        tls.useStartTls = false;
      };
    };
  };
}
