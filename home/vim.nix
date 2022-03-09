{ config, lib, pkgs,  ... }:
let
  vim-gas = pkgs.vimUtils.buildVimPlugin {
    name = "vim-gas";
    src = pkgs.fetchFromGitHub {
      owner = "Shirk";
      repo = "vim-gas";
      rev = "c6da2e0f6663c6b1dbd954c55324035e59636f31";
      sha256 = "0y2dyksi1fbwgr8fg98bxrz4wcc7pl9aymbciml357yaq5bs8hx8";
    };
  };

  easygrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-easygrep";
    src = pkgs.fetchFromGitHub {
      owner = "dkprice";
      repo = "vim-easygrep";
      rev = "d0c36a77cc63c22648e792796b1815b44164653a";
      sha256 = "0y2p5mz0d5fhg6n68lhfhl8p4mlwkb82q337c22djs4w5zyzggbc";
    };
  };
in {
  programs.vim = {
    enable = true;
    plugins = [
      vim-gas
      easygrep
      pkgs.vimPlugins.vim-colors-solarized
      pkgs.vimPlugins.vim-tmux-navigator
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.nerdcommenter
      pkgs.vimPlugins.YouCompleteMe
      pkgs.vimPlugins.vim-better-whitespace
      pkgs.vimPlugins.vim-flake8
      pkgs.vimPlugins.vim-go
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-ledger
    ];
    extraConfig = ''
    set nocompatible
    filetype plugin indent on

    " Color scheme
    syntax on
    set background=dark
    colorscheme solarized
    hi Normal ctermbg=none
    
    " Tab Sizes
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    
    set cc=80
    
    set hidden
    
    set hlsearch
    set encoding=utf-8
    
    set expandtab
    
    " Automatic Indenting
    set smarttab
    set autoindent
    
    " Persit undos between files and restarts
    set undofile
    set undodir=$HOME/.vim/undo-dir
    
    " Turn on line numbers
    set number
    
    let g:airline_solarized_bg='dark'
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

		autocmd BufNewFile,BufRead *.s :set filetype=gas
    
    " Keybinds
    map <Tab> <C-^>
    '';
  };
}
