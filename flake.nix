{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fel.url = "github:zabot/fel";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    let
      user = {
        unixname = "zach";
        name = "Zach Anderson";
        email = "zach@zabot.dev";
      };
    in
    rec {
      packages.x86_64-linux = {
        offline-installer-iso = nixosConfigurations.installer.config.system.build.isoImage;
      };

      homeConfigurations.default = home-manager.lib.homeManagerConfiguration (import ./home);

      nixosConfigurations = let
        common = { host, modules ? [] }: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
          ] ++ modules;
          specialArgs = {
            inherit inputs;
            global = {
              inherit user host;
            };
          };
        };

        diskoSystems = {
          zach-replit-framework = common {
            host = "replit-framework";
            modules = [
              nixos-hardware.nixosModules.framework-13-7040-amd
            ];
          };
        };
      in {
        installer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./installer
          ];
          specialArgs = {
            configurations = diskoSystems;
          };
        };

        zach-xps = common {
          host = "xps";
        };

        zach-framework = common {
          host = "framework";
        };

        zach-desktop = common {
          host = "desktop";
        };
      } // diskoSystems;
    };
}
