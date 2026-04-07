{ pkgs }:
{
  package = pkgs.age.withPlugins (ps: [
    ps.age-plugin-tpm
    ps.age-plugin-yubikey
  ]);

  identityPaths = [
    "/etc/age-tpm-identity.txt"
    "/etc/age-yk-identity.txt"
  ];
}
