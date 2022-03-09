{ config, lib, pkgs,  ... }:
let
  plugins = import ./vim-plugins.nix { pkgs=pkgs; };
in {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      plugins.vim-gas
      plugins.easygrep
      vim-colors-solarized
      vim-tmux-navigator
      vim-airline
      vim-airline-themes
      nerdcommenter
      YouCompleteMe
      vim-better-whitespace
      vim-flake8
      vim-go
      vim-nix
      vim-ledger
    ];
    extraConfig = builtins.readFile ./vimrc;
  };
}
