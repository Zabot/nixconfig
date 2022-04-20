{ pkgs
, system
, config
, options
, ...
}:
let
  i3lock-color = (pkgs.callPackage ./lock-color.nix) {};
  stripHex = name: color: (builtins.substring 1 6 color);
  colors = builtins.mapAttrs stripHex system.colors;
  lock = builtins.concatStringsSep " " [
    "${i3lock-color}/bin/i3lock-color"
    "-e -k --force-clock --pass-screen-keys"
    "-c ${colors.background}"
    "-C -i ${../../../../resources/lock.png}"
    "--refresh-rate=60"

    "--inside-color=00000000"
    "--insidewrong-color=00000000"
    "--insidever-color=00000000"
    "--line-uses-inside"

    "--wrong-text=\"\""
    "--verif-text=\"\""
    "--noinput-text=\"\""

    "--ring-color=${colors.background-hl}"
    "--ringver-color=${colors.focus}"
    "--ringwrong-color=${colors.error}"
    "--keyhl-color=${colors.secondary}"
    "--bshl-color=${colors.secondary}"
    "--verif-color=${colors.focus}"
    "--wrong-color=${colors.error}"

    "--time-color=${colors.secondary}"
    "--time-font=Overpass"
    "--time-size=128"
    "--time-align=1"
    "--time-pos=\"30:h-90-30\""
    "--time-str=\"%H:%M %p\""

    "--date-color=${colors.secondary}"
    "--date-font=Overpass"
    "--date-size=90"
    "--date-align=1"
    "--date-str=\"%A %B %d\""
    "--date-pos=\"tx:h-30\""

    "--indicator"
    "--ind-pos=\"w/2-541:h/2\""
    "--radius 97"
    "--ring-width 6"
    "--polygon-sides=6"
    "--polygon-highlight=2"
  ];
in {
  config.lock = {
    cmd = lock;
  };

  options.lock = {
    cmd = pkgs.lib.mkOption {
      type = pkgs.lib.types.str;
    };
  };
}
