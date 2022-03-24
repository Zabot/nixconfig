{ config, pkgs, ... }:
{
  imports = [
    # Autogenerated by nixos installer
    ./hardware-configuration.nix
    # Import definition of global options
    ./global.nix
    # Import common system configuration
    ./system
    # Override common config with machine specific config
    ./machines
    # Home manager config
    ./home
  ];


  # These should be modified on each machine
  config.global.host = "framework";
  config.global.user = {
    # NOTE: This configuration is aggressively specific to a single user.
    unixname = "zach";
    name = "Zach Anderson";
    email = "zach.inbox@gmail.com";
  };
}
