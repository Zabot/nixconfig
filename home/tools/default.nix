{ config, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./vim
    ./gpg
  ];
}
