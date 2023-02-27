{ config, ... }:
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./zsh.nix
    ./vim
    ./gpg
  ];
}
