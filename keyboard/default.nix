{
  pkgs,
  stdenv,
  qmk,
}:
stdenv.mkDerivation {
  name = "firmware";
  src = pkgs.fetchFromGitHub {
    owner = "qmk";
    repo = "qmk_firmware";
    rev = "refs/tags/0.33.13";
    hash = "sha256-FDN+pQrgdKqleku5L6xViajY1jEkjZZX5ZGx46N8dkw=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    qmk
  ];

  buildPhase = ''
    # Need to copy this in the build phase since its easier then generating a
    # patch
    layout=keyboards/zsa/moonlander/keymaps/layout
    mkdir -p $layout
    cp -r ${./.}/* $layout

    make zsa/moonlander:layout:bin
  '';

  installPhase = ''
    mkdir -p $out
    cp zsa_moonlander_layout.bin $out/firmware.bin

    cat > $out/flash.sh <<EOF
    #!/bin/sh
    ${qmk}/bin/qmk flash $out/firmware.bin
    EOF
    chmod u+x $out/flash.sh
  '';
}
