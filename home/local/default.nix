{
  pkgs,
  ...
}:
{
  imports = [
    ./email.nix
    ./vdir.nix
    ./irc.nix
    ./rss.nix
  ];

  services = {
    udiskie = {
      enable = true;
      automount = true;
    };

    gpg-agent.enable = false;

    ssh-agent = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    weechat
    ncmpcpp

    age
    age-plugin-tpm
    age-plugin-yubikey
  ];

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-somafm
      mopidy-tunein
    ];
    settings = {
      file = {
        media_dirs = [
          "~/music"
        ];
      };
    };
  };

  programs.taskwarrior = {
    enable = true;
    config = {
      "alias.note" = "execute '${./note.sh}' $@";
    };
  };
}
