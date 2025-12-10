{
  config,
  pkgs,
  nixosVersion,
  home-manager,
  fel,
  nur-pkgs,
  ...
}:
let
  name = config.global.user.unixname;
in
{
  imports = [ home-manager.nixosModule ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = builtins.listToAttrs [
    {
      inherit name;
      value = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "adbusers"
          "video"
          "docker"
          "plugdev"
          "networkmanager"
          "dialout"
        ];
        shell = pkgs.fish;
      };
    }
  ];
  programs.fish.enable = true;


  home-manager.users = builtins.listToAttrs [
    {
      inherit name;
      value = import ./home;
    }
  ];
  home-manager.extraSpecialArgs = {
    inherit fel nur-pkgs;
    system = config;
    extraConfig = {
      desktop.useWayland = config.desktop.useWayland;
    };
  };
}
