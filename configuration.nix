{
  config,
  pkgs,
  global,
  ...
}:
{
  imports = [
    # Import color schemes
    ./colors
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
  ];
  config.nixpkgs.overlays = [ (import ./overlay) ];

  config.global = global;
  config.colors = (import ./colors/solarized.nix).dark;
  config.system.stateVersion = "25.11";
}
