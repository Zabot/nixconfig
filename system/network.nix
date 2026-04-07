{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking = {
    hostName = "${config.global.user.unixname}-${config.global.host}";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      ensureProfiles = {
        environmentFiles = [
          config.age.secrets.hotspot-env.path
          config.age.secrets.home-env.path
        ];
        profiles =
          let
            interface-name = "wlp1s0";
          in
          {
            home = {
              connection = {
                inherit interface-name;
                id = "$HOME_SSID";
                type = "wifi";
                uuid = "44a54ce4-f171-45d8-800b-1814929dae97";
              };
              wifi = {
                mode = "infrastructure";
                ssid = "$HOME_SSID";
              };
              wifi-security = {
                auth-alg = "open";
                key-mgmt = "wpa-psk";
                psk = "$HOME_PSK";
              };
            };
            hotspot = {
              connection = {
                inherit interface-name;
                id = "$HOTSPOT_SSID";
                type = "wifi";
                uuid = "ad179f49-bacb-44b3-908d-b65041df8500";
              };
              wifi = {
                mode = "infrastructure";
                ssid = "$HOTSPOT_SSID";
              };
              wifi-security = {
                auth-alg = "open";
                key-mgmt = "wpa-psk";
                psk = "$HOTSPOT_PSK";
              };
            };
          };
      };
    };
  };
}
