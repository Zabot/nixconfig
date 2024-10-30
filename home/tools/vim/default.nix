{
  config,
  lib,
  pkgs,
  ...
}:
let
  plugins = import ./vim-plugins.nix { pkgs = pkgs; };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # UI
      plugins.solarized
      lualine-nvim

      # Utilities
      vim-rooter # Jump to git root when opening file
      nerdcommenter # Togglable comments
      vim-better-whitespace # Highlight trailing whitespace

      # Language syntax support
      vim-crates
      vim-toml
      vim-nix
      vim-terraform

      # LSP
      nvim-lspconfig
      lsp-status-nvim

      # Auto complete
      nvim-cmp
      cmp-nvim-lsp
      luasnip

      telescope-nvim
      telescope-ui-select-nvim

      (nvim-treesitter.withAllGrammars)
      nvim-treesitter-context

      go-nvim
    ];
    extraLuaConfig = builtins.concatStringsSep " " (
      builtins.map builtins.readFile [
        ./init.lua
        ./lsp.lua
      ]
    );
    extraPackages = with pkgs; [
      rust-analyzer
      sumneko-lua-language-server
      nodePackages.pyright
      nodePackages.typescript-language-server
      gopls
    ];
  };
}
