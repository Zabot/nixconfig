{
  config,
  pkgs,
  nixosVersion,
  inputs,
  ...
}:
let
  name = config.global.user.unixname;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

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
          "tss"
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
    inherit inputs;
    system = config;
  };
}
