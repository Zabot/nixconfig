{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    goval.url = "git+file:/home/zach/replit/goval";
    fel.url = "github:zabot/fel";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      goval,
      fel,
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
          goval.nixosModules.default
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
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration (import ./home/home-manager.nix);
    };
}
