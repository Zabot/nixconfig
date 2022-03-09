{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "video" "docker" "plugdev" ];
    shell = pkgs.zsh;
  };

  home-manager.users.zach = import ./home-manager.nix;
}
