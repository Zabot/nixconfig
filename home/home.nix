{ config, buildVimPluginFrom2Nix, fetchFromGitHub, lib, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./alacritty.nix
    ./vim.nix
    ./email.nix
    ./git.nix
    ./zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.overlays = [
    #(self: super: {
      #vimPlugins = super.vimPlugins.overrideScope' (vself: vsuper: {
        #vim-gas = buildVimPluginFrom2Nix {
          #pname = "align";
          #version = "0.14";
          #src = fetchFromGitHub {
            #owner = "Shirk";
            #repo = "vim-gas";
            #rev = "c6da2e0f6663c6b1dbd954c55324035e59636f31";
            #sha256 = "0acacr572kfh7jvavbw61q5pkwrpi1albgancma063rpax1pddgp";
          #};
          #meta.homepage = "https://github.com/Shirk/vim-gas";
        #};
      #});
    #})
  #];

  #fonts.fontconfig.enable = true;

  home.stateVersion = "21.05";
  home.username = "zach";
  home.homeDirectory = "/home/zach";
  home.packages = [
    pkgs.htop
    pkgs.keepassxc
    pkgs.ripgrep
    pkgs.libnotify
    pkgs.weechat
    pkgs.weechatScripts.wee-slack
    pkgs.python38
    pkgs.python38Packages.poetry
    pkgs.ledger
    pkgs.discord
    pkgs.kicad
    pkgs.pavucontrol
  ];

  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.rofi.enable = true;
  programs.neomutt.enable = true;

  services.udiskie.enable = true;
  services.udiskie.automount = true;
  services.imapnotify.enable = true;

  services.polybar.enable = true;
  services.polybar.script = "polybar top &";
  services.polybar.package = pkgs.polybarFull;

  services.random-background.enable = true;
  services.random-background.imageDirectory = "/etc/nixos/wallpaper";

}
