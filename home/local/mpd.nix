{
  pkgs,
  ...
}:
{
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-somafm
      mopidy-tunein
      mopidy-local
      mopidy-notify
    ];
    settings = {
      # Local backend indexes music instead of just exposing files
      local = {
        enabled = true;
        media_dir = "~/music";
      };
      notify = {
        enabled = true;
      };
    };
  };

  # mopidy-scan.service is defined by home manager if mopidy-local is included
  # in the extensions.
  systemd.user.paths.mopidy-scan = {
    Path.PathChanged = "%h/music";
    Install.WantedBy = [
      "mopidy.service"
    ];
  };
}
