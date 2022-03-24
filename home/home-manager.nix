{ config, pkgs, global, ... }:

{
  imports = [
    ./email.nix
    ./desktop
    ./tools
  ];
  #fonts.fontconfig.enable = true;

  home = {
    stateVersion = "21.05";
    username = global.user.unixname;
    homeDirectory = "/home/${global.user.unixname}";
    packages = with pkgs; [
      htop
      keepassxc
      ripgrep
      libnotify
      weechat
      weechatScripts.wee-slack
      python38
      python38Packages.poetry
      ledger
      kicad
      pavucontrol
    ];
  };


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
  services.random-background.imageDirectory = "${../resources/wallpaper}";
}
