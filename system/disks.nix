{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.disko = with lib; {
    rootDisk = mkOption { type = types.str; };
    enable = lib.mkEnableOption "enable disko disk managment";
  };

  config.disko.devices = lib.mkIf config.disko.enable {
    disk = {
      root = {
        type = "disk";
        device = config.disko.rootDisk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "EFI";
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/tmp" = {
                  mountpoint = "/tmp";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
              };
            };
          };
          swap = {
            size = "64G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
        };
      };
    };
  };
}
