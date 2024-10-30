{ config, ... }:
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./shell
    ./vim
    ./gpg
    ./ssh
  ];
}
