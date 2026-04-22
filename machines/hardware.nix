{ lib, ... }:
{
  # These options provide information about the hardware of a particular machine
  # Default WiFi
  # Monitor configuration (What about docking)
  # Default network
  options.hardware = with lib; {
    defaultWifi = mkOption { type = types.str; };

    power = mkOption {
      type = types.submodule {
        options = {
          battery = mkOption { type = types.str; };
          adapter = mkOption { type = types.str; };
        };
      };
    };

    displays = mkOption {
      type = types.attrs {
        options = {
          type = types.submodule {
            options = {
              fingerprint = mkOption { type = types.str; };
              mode = mkOption { type = types.str; };
              rate = mkOption { type = types.str; };
              rotate = mkOption { type = types.str; };
            };
          };
        };
      };
    };
  };
}
