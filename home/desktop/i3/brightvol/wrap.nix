# TODO Move this into an overlay so we can use it everywhere
{ stdenvNoCC, makeWrapper }: {src, env ? {}, args ? ""}:
let
  toSet = name: value: "--set '${name}' '${value}'";
in stdenvNoCC.mkDerivation {
  name = baseNameOf src;
  phases = [ "installPhase" ];

  buildInputs = [ makeWrapper ];
  installPhase = ''makeWrapper ${src} $out \
    ${builtins.concatStringsSep " " (builtins.attrValues (builtins.mapAttrs toSet env))} \
    --add-flags ${args}
  '';
}
