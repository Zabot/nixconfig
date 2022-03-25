{ lib, ... }:
{
  # These options provide information about the hardware of a particular machine
  # Default WiFi
  # Monitor configuration (What about docking)
  # Default network
  options.hardware = with lib; {
    defaultWifi = mkOption {
      type = types.str;
    };

    power = mkOption {
      type = types.submodule {
        options = {
          battery = mkOption {
            type = types.str;
          };
          adapter = mkOption {
            type = types.str;
          };
        };
      };
    };
  };
}
