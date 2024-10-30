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

  cargoSha256 = "1hsi65a13adk0yppghiknqzm50g7a8vq4g5rf0y6lby99c9fnff3";
  verifyCargoDeps = true;
}
