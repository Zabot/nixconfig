{
  config,
  lib,
  pkgs,
  ...
}:
{
  services = {
    # This only enables the periodic syncing, the program
    # has to be enabled seperately
    vdirsyncer.enable = true;
  };

  programs = {
    khal.enable = true;
    vdirsyncer.enable = true;
    khard.enable =true;
  };

  accounts.calendar = {
    basePath = "calendar";
    accounts = {
      fastmail = {
        vdirsyncer = {
          enable = true;
          collections = [
            # From a is a variable that means sync everything from the a (remote) side
            "from a"
          ];
        };
        khal = {
          enable = true;
          type = "discover";
        };
        remote = {
          type = "caldav";
          url = "https://caldav.fastmail.com/";
          userName = "zabot@fastmail.com";
          passwordCommand = [
            "${pkgs.coreutils}/bin/cat"
            config.age.secrets.fastmail-pass.path
          ];
        };
      };
    };
  };

  accounts.contact = {
    basePath = "contacts";
    accounts = {
      fastmail = {
        vdirsyncer = {
          enable = true;
          collections = [
            "from a"
          ];
        };
        # This is probably uneccassary, I think its just for birthdays
        #khal = {
          #enable = true;
          #readOnly = true;
        #};
        khard = {
          enable = true;
          type = "discover";
        };
        remote = {
          type = "carddav";
          url = "https://carddav.fastmail.com/";
          userName = "zabot@fastmail.com";
          passwordCommand = [
            "${pkgs.coreutils}/bin/cat"
            config.age.secrets.fastmail-pass.path
          ];
        };
      };
    };
  };
}
