{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./starship.nix ];

  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
  };
}
