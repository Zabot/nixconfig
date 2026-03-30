{
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  imports = [
    # Home configuration that is useful on a system that
    # may be used over ssh, but is not the local system
    # (e.g. vim)
    ./remote

    # Configuration that is useful on a local system that
    # does not have a display server.
    # (e.g. mutt, udiskie, taskwarrior)
    ./local

    # Full graphical environment
    ./desktop

    inputs.nur.modules.homeManager.default
  ];

  config = {
    nixpkgs.overlays = [
      (import ../overlay)
    ];

    home = {
      stateVersion = system.system.stateVersion;
      username = system.global.user.unixname;
      homeDirectory = "/home/${system.global.user.unixname}";
    };

    programs.home-manager.enable = true;
  };
}
