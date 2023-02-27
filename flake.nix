{
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }: let
    user = {
      unixname = "zach";
      name = "Zach Anderson";
      email = "zach@zabot.dev";
    };
  in {
    nixosConfigurations.zach-xps = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
      specialArgs = {
        inherit home-manager;
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
        inherit home-manager;
        global = {
          inherit user;
          host = "framework";
        };
      };
    };
  };
}

