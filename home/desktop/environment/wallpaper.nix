{ pkgs, inputs, ... }:
let
  mb = inputs.mandlebrot.packages.x86_64-linux.default;
  colorscheme = [
    "002b36"
    "073642"
    "586e75"
  ];
  color_args = (builtins.concatStringsSep " " (builtins.map (c: "-g ${c}") colorscheme));

  configs =
    let
      common = {
        width = 1920;
        height = 1080;
        steps = 5000;

        # This point is from wikipedia, it has a lot of good zooms
        # https://en.wikipedia.org/wiki/File:Mandel_zoom_14_satellite_julia_island.jpg
        real = "-0.743643887037151";
        imag = "0.131825904205330";
      };
    in
    builtins.map
      (
        zoom:
        (
          common
          // {
            inherit zoom;
          }
        )
      )
      [
        1
        10000
        200000
        59979000000.0
      ];

  toCmdArgs =
    attrs:
    builtins.concatStringsSep " " (
      builtins.attrValues (builtins.mapAttrs (flag: value: "--${flag} ${builtins.toString value}") attrs)
    );

  wallpapers = pkgs.runCommand "wallpapers" { } ''
    mkdir -p $out
    ${builtins.concatStringsSep "\n" (
      pkgs.lib.imap0 (
        index: value:
        "${mb}/bin/mandlebrot ${color_args} ${toCmdArgs value} -o $out/${builtins.toString index}.ppm"
      ) configs
    )}
  '';
in
{
  services.wpaperd = {
    enable = true;

    settings = {
      default = {
        duration = "8h";
        mode = "center";
        sorting = "random";
      };
      any = {
        path = wallpapers;
      };
    };
  };
}
