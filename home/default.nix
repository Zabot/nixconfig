{ config, pkgs, nixosVersion, home-manager, ... }:
let
  name = config.global.user.unixname;
in
{
  imports = [
    home-manager.nixosModule
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users= builtins.listToAttrs[ {
    inherit name;
    value = {
      isNormalUser = true;
      extraGroups = [ "wheel" "adbusers" "video" "docker" "plugdev" "networkmanager" ];
      shell = pkgs.zsh;
    };
  } ];

  home-manager.users = builtins.listToAttrs [ {
    inherit name;
    value = import ./home-manager.nix;
  } ];
  home-manager.extraSpecialArgs = {
    system = config;
    extraConfig = {
      desktop.useWayland = config.desktop.useWayland;
    };
  };
}
