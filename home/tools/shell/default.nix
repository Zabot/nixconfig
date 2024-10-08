{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./starship.nix ];

  programs.nix-index.enable = true;
  #programs.nix-index.enableZshIntegration = true;

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
  };
}
