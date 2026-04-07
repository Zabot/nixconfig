{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  services.pcscd.enable = true;

  # Setup identities for yubikeys and the TPM before we start trying to decrypt anything
  system.activationScripts = {
    ageTpmEnroll = {
      text = ''
        if [ ! -f "/etc/age-tpm-identity.txt" ]; then
          ${pkgs.age-plugin-tpm}/bin/age-plugin-tpm --generate --output /etc/age-tpm-identity.txt
        fi
      '';
    };
    ageYkImport = {
      text = ''
        known=$(${pkgs.coreutils}/bin/cat /etc/age-yk-identity.txt)
        connected=$(${pkgs.age-plugin-yubikey}/bin/age-plugin-yubikey -i 2>&1)
        joined=$(${pkgs.coreutils}/bin/echo -e "$known\n$connected" \
          | ${pkgs.gnugrep}/bin/grep -o 'AGE-PLUGIN.*' \
          | ${pkgs.coreutils}/bin/sort \
          | ${pkgs.coreutils}/bin/uniq)

        # TODO Block until there's at least one identitiy
        echo $joined > /etc/age-yk-identity.txt
      '';
    };
    agenixInstall.deps = [
      "ageTpmEnroll"
      "ageYkImport"
    ];
  };

  age =
    let
      ageCommon = (import ./common.nix) { inherit pkgs; };
    in
    {
      ageBin = "${ageCommon.package}/bin/age";
      identityPaths = ageCommon.identityPaths;

      secrets = {
        home-env = {
          file = ./secrets/home-env.age;
        };
        hotspot-env = {
          file = ./secrets/hotspot-env.age;
        };
      };
    };
}
