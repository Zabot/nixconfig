{
  stdenv,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "jackrabbit";
  version = "master";

  src = fetchFromGitHub {
    owner = "zabot";
    repo = pname;
    rev = version;
    sha256 = "0qgjww2xav4k8zbqa8jl83bd6yi9nzs5yyf9j57awi5n0n9r45z0";
  };

  cargoHash = "sha256-fL4jWon0QYSU1taNyfYimBAGG2vSwRtIo27cg0nv+qc=";
  verifyCargoDeps = true;
}
