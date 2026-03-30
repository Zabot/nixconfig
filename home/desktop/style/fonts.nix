{ pkgs, ... }:
let
  sans = pkgs.iosevka-bin.override {
    variant = "Aile";
  };

  serif = pkgs.iosevka-bin.override {
    variant = "Etoile";
  };

in {
  home.packages = [
    # For the quasi-proportional
    pkgs.iosevka
    # Monospace patched with symbols
    pkgs.nerd-fonts.iosevka

    # Original UI font for comparison
    pkgs.overpass
    sans
    serif

    # Nerd font symbols only for use in UI
    pkgs.nerd-fonts.symbols-only
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Iosevka Nerd Font Mono"
        "Symbols Nerd Font Mono"
      ];
      serif = [
        "Iosevka Etoile"
        "Symbols Nerd Font"
      ];
      sansSerif = [
        "Iosevka Aile"
        "Symbols Nerd Font"
      ];
      emoji = [
        "Symbols Nerd Font"
      ];
    };
  };
}
