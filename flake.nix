{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    fel.url = "github:zabot/fel";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    goval.url = "git+file:/home/zach/p/goval-main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      fel,
      nur,
      goval,
      nixos-hardware,
    }@inputs:
    let
      user = {
        unixname = "zach";
        name = "Zach Anderson";
        email = "zach@zabot.dev";
      };
    in
    {
      nixosConfigurations.zach-xps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit home-manager fel inputs nur;
          global = {
            inherit user;
            host = "xps";
          };
        };
      };
      nixosConfigurations.zach-framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit home-manager fel inputs nur;
          global = {
            inherit user;
            host = "framework";
          };
        };
      };
      nixosConfigurations.zach-replit-framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          goval.nixosModules.default
          nixos-hardware.nixosModules.framework-13-7040-amd
        ];
        specialArgs = {
          inherit home-manager fel inputs;
          global = {
            inherit user;
            host = "replit-framework";
          };
          nur-pkgs = nur.legacyPackages."x86_64-linux";
        };
      };
      nixosConfigurations.zach-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit home-manager fel inputs;
          global = {
            inherit user;
            host = "desktop";
          };
        };
      };
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration (import ./home);
    };
}
