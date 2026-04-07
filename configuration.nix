{
  config,
  pkgs,
  global,
  ...
}:
{
  imports = [
    # Import icon set
    ./icons
    # Import definition of global options
    ./global.nix
    # Import common system configuration
    ./system
    # Override common config with machine specific config
    ./machines
    # Home manager config
    ./home.nix
    ./secrets
  ];
  config.nixpkgs.overlays = [ (import ./overlay) ];

  config.global = global;
  config.system.stateVersion = "25.11";
}
