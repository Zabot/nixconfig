{ config, pkgs, system, ... }:
{
  imports = [
    ./modules
    ./email.nix
    ./desktop
    ./tools
  ];
  #fonts.fontconfig.enable = true;

  nixpkgs.overlays = let
    moz-rev = "master";
    moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
    nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
  in [
    (import ../overlay)
    nightlyOverlay
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
    sessionVariables = {
      MOZ_USE_XINPUT2=1;
    };
  };


  programs.home-manager.enable = true;
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.latest.firefox-nightly-bin;
  programs.rofi.enable = true;
  programs.neomutt.enable = true;

  services.udiskie.enable = true;
  services.udiskie.automount = true;
  services.imapnotify.enable = true;

  services.random-background.enable = true;
  services.random-background.imageDirectory = "${../resources/wallpaper}";
}
