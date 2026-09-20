{
  pkgs,
  withSecrets,
  ...
}:
{
  imports = [
    ./rss.nix
    ./ssh.nix
  ]
  ++ (
    # We have to pass this through explicity since you can't reference config
    # in imports. Alternatively this would all need to be lib.mkIf'ed
    if withSecrets then
      [
        ./vdir.nix
        ./irc.nix
        ./email.nix
      ]
    else
      [ ]
  );

  services = {
    udiskie = {
      enable = true;
      automount = true;
    };

    gpg-agent.enable = false;
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
