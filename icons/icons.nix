{
  stdenv,
  python3,
  fetchurl,
  fetchzip,
  fontforge,
}:
let
  version = "v3.4.0";
  font = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/NerdFontsSymbolsOnly.tar.xz";
    sha256 = "sha256-A0KEuMp96vqL2PCbDL/H7A6yFRDg/xukM9CM8I6NACc=";
    stripRoot = false;
  };
  css = fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/${version}/css/nerd-fonts-generated.css";
    name = "nerd.css";
    sha256 = "sha256-PwJbobdKoRVqJNAX/+GXMJonGtr7t1d+prSLiOXEAWU=";
  };
in
stdenv.mkDerivation {
  name = "nerd-icons";

  src = [
    font
    css
  ];
  unpackPhase = "true";

  buildPhase = ''
    mkdir -p svg/
    ls -R ${font}
    ${fontforge}/bin/fontforge -quiet -lang=ff -c 'Open($1); SelectWorthOutputting(); foreach Export("svg/%u.svg"); endloop;' ${font}/SymbolsNerdFontMono-Regular.ttf
  '';

  installPhase = ''
    mkdir -p $out/share/nerd-icons
    mv svg/* $out/share/nerd-icons
    ${python3}/bin/python3 ${./get.py} ${css} -C $out -o $out/default.nix
  '';
}
