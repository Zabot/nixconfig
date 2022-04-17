{ stdenv
, python3
, fetchurl
, fontforge
}:
let
  font = fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/2.1.0/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf";
    name = "nerd.ttf";
    sha256 = "078ynwfl92p8pq1n3ic07248whdjm30gcvkq3sy9gas1vlpyg6an";
  };
  css = fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/2.1.0/css/nerd-fonts-generated.css";
    name = "nerd.css";
    sha256 = "1qhgssv28ck12am1hmxld8vwccfxfjzsgjdh6jr9vivgra182y1m";
  };
in stdenv.mkDerivation {
  name = "nerd-icons";

  src = [
    font
    css
  ];
  unpackPhase = "true";

  buildPhase = ''
    mkdir -p svg/
    ${fontforge}/bin/fontforge -quiet -lang=ff -c 'Open($1); SelectWorthOutputting(); foreach Export("svg/%u.svg"); endloop;' ${font}
  '';

  installPhase = ''
    mkdir -p $out/share/nerd-icons
    mv svg/* $out/share/nerd-icons
    ${python3}/bin/python3 ${./get.py} ${css} -C $out -o $out/default.nix
  '';
}
