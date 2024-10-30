{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    fel.url = "github:zabot/fel";
    nur.url = github:nix-community/NUR;
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      fel,
      nur,
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
          nur.nixosModules.nur
          ./configuration.nix
        ];
        specialArgs = {
          inherit home-manager fel inputs;
          global = {
            inherit user;
            host = "xps";
          };
        };
      };
      nixosConfigurations.zach-framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
        specialArgs = {
          inherit home-manager fel inputs;
          global = {
            inherit user;
            host = "framework";
          };
        };
      };
      nixosConfigurations.zach-replit-framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nur.nixosModules.nur
          ./configuration.nix
        ];
        specialArgs = {
          inherit home-manager fel inputs nur;
          global = {
            inherit user;
            host = "replit-framework";
          };
        };
      };
      nixosConfigurations.zach-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
        specialArgs = {
          inherit home-manager;
          global = {
            inherit user;
            host = "desktop";
          };
        };
      };
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration (import ./home/home-manager.nix);
    };
}
