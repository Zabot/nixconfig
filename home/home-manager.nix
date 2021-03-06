{ config, pkgs, system, ... }:

{
  imports = [
    ./modules
    ./email.nix
    ./desktop
    ./tools
  ];
  #fonts.fontconfig.enable = true;

  nixpkgs.overlays = [
    (import ../overlay)
  ];

  home = {
    stateVersion = system.system.stateVersion;
    username = system.global.user.unixname;
    homeDirectory = "/home/${system.global.user.unixname}";
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

  services.random-background.enable = true;
  services.random-background.imageDirectory = "${../resources/wallpaper}";
}
