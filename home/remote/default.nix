{ config, pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./shell
    ./ssh
    ./vim
  ];

  # Packages that are so generally useful they get installed
  # by default. Most packages should be managed by a per project
  # direnv
  home.packages = with pkgs; [
    htop
    ripgrep
    inputs.fel.packages.x86_64-linux.fel
    dig
    jq
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
