{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";

    agenix.url = "github:ryantm/agenix";
    disko.url = "github:nix-community/disko/latest";
    fel.url = "github:zabot/fel";
    mandlebrot = {
      url = "github:zabot/mandlebrot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl.url = "github:nix-community/nixGL";

    secrets = {
      url = "git+ssh://de4910@de4910.rsync.net/~/secrets?shallow=1";
    };
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

      pkgs = (import nixpkgs) {
        system = "x86_64-linux";
      };
    in
    rec {
      packages.x86_64-linux = {
        offline-installer-iso = nixosConfigurations.installer.config.system.build.isoImage;
        keyboard = pkgs.callPackage ./keyboard { };
      };

      homeConfigurations = let
        config = {withSecrets}: (home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home
            {
              home.packages = [
                # Nix built applications don't get along with non nixos libgl
                # nixgl is a wrapper for launching them.
                inputs.nixgl.packages.x86_64-linux.default
              ];
            }
          ];
          extraSpecialArgs = {
            inherit inputs withSecrets;
            system = {
              system.stateVersion = "25.11";
              global.user = user;
            };
          };
        });
      in {
        "zach" = config {
          withSecrets = true;
        };
        "public" = config {
          withSecrets = false;
        };
      };

      devShells.x86_64-linux.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          git-annex
          nixfmt
          nixfmt-tree
          yubikey-manager
          age
          age-plugin-tpm
          age-plugin-yubikey
          inputs.agenix.packages.x86_64-linux.default
          nil
          sbctl
        ];
      };

      nixosConfigurations =
        let
          common =
            {
              host,
              withSecrets ? true,
              modules ? [ ],
            }:
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                ./configuration.nix
              ]
              ++ modules;
              specialArgs = {
                inherit inputs withSecrets;
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
        in
        {
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
        }
        // diskoSystems;
    };
}
